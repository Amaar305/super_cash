// data/datasources/remote/auth_client.dart
// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:token_repository/token_repository.dart';

/// ---- Domain-safe exceptions

class ApiException implements Exception {
  ///
  ApiException(this.message, {this.statusCode, this.details});
  final int? statusCode;
  final String message;
  final Map<String, dynamic>? details;
  @override
  String toString() => 'ApiException($statusCode): $message';
}

class NetworkException implements Exception {
  NetworkException(this.message);
  final String message;
  @override
  String toString() => 'NetworkException: $message';
}

/// Thrown when refresh token is invalid/expired.
class AuthClient {
  /// {@macro auth_client}
  const AuthClient({
    required http.Client client,
    required TokenRepository tokenRepository,
    required String baseUrl,
    Duration defaultTimeout = const Duration(seconds: 30),
    this.refreshEndpoint = '/auth/token/refresh/',
  })  : _client = client,
        _tokenRepository = tokenRepository,
        _baseUrl = baseUrl,
        _defaultTimeout = defaultTimeout;

  final http.Client _client;
  final TokenRepository _tokenRepository;
  final String _baseUrl;
  final Duration _defaultTimeout;

  /// Endpoint to refresh token (appended to baseUrl)
  final String refreshEndpoint;

  // Prevent multiple concurrent refreshes (all 401s await the same refresh).
  static Completer<void>? _refreshCompleter;

  /// Main request entry point
  Future<http.Response> request({
    required String method, // 'GET', 'POST', ...
    required String path,
    bool withToken = true,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body, // String | Map | List<int> | null
    MediaType? contentType, // overrides Content-Type
    Duration? timeout,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final initialHeaders = _prepareHeaders(headers, contentType: contentType);

    // Attach token if requested
    final accessToken =
        withToken ? await _tokenRepository.getAccessToken() : null;
    if (withToken && accessToken != null) {
      initialHeaders['Authorization'] = 'Bearer $accessToken';
    }

    try {
      final first = await _sendRequest(
        method: method,
        uri: uri,
        headers: initialHeaders,
        body: body,
        timeout: timeout ?? _defaultTimeout,
      );

      if (first.statusCode != 401 || !withToken) {
        _throwOnHttpError(first);
        return first;
      }

      // 401 and we used token -> try refresh once
      final retried = await _refreshTokenAndRetry(
        method: method,
        uri: uri,
        headers: initialHeaders,
        body: body,
        timeout: timeout ?? _defaultTimeout,
      );

      _throwOnHttpError(retried);
      return retried;
    } on SocketException {
      throw NetworkException('No internet connection.');
    } on TimeoutException {
      throw NetworkException('Request timed out.');
    } on HttpException {
      throw NetworkException('Network error occurred.');
    }
  }

  /// Multipart file upload (POST)
  Future<http.Response> multipart({
    required String path,
    required File file,
    String fileField = 'file',
    Map<String, String>? fields,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    bool withToken = true,
    MediaType? contentType, // default guessed below
    Duration? timeout,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final accessToken =
        withToken ? await _tokenRepository.getAccessToken() : null;

    Future<http.Response> send({String? bearer}) async {
      final req = http.MultipartRequest('POST', uri);

      if (headers != null) req.headers.addAll(headers);
      if (bearer != null) req.headers['Authorization'] = 'Bearer $bearer';
      if (fields != null) req.fields.addAll(fields);

      final ct = contentType ??
          _guessMediaTypeFromPath(file.path) ??
          MediaType('application', 'octet-stream');

      req.files.add(
        await http.MultipartFile.fromPath(
          fileField,
          file.path,
          filename: p.basename(file.path),
          contentType: ct,
        ),
      );

      final streamed = await req.send().timeout(timeout ?? _defaultTimeout);
      return http.Response.fromStream(streamed);
    }

    try {
      final first = await send(bearer: withToken ? accessToken : null);

      if (first.statusCode != 401 || !withToken) {
        _throwOnHttpError(first);
        return first;
      }

      // Refresh then retry
      final newAccess = await _refreshAccessTokenLocked();
      final retried = await send(bearer: newAccess);
      _throwOnHttpError(retried);
      return retried;
    } on SocketException {
      throw NetworkException('No internet connection.');
    } on TimeoutException {
      throw NetworkException('Request timed out.');
    } on HttpException {
      throw NetworkException('Network error occurred.');
    }
  }

  // ---------------------- Internals ------------------------------------------

  Uri _buildUri(String path, Map<String, dynamic>? queryParams) {
    // Avoid double slashes
    final base = _baseUrl.endsWith('/')
        ? _baseUrl.substring(0, _baseUrl.length - 1)
        : _baseUrl;
    final cleanPath = path.startsWith('/') ? path : '/$path';
    final uri = Uri.parse('$base$cleanPath');
    if (queryParams == null || queryParams.isEmpty) return uri;
    return uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        ...queryParams.map((k, v) => MapEntry(k, v?.toString())),
      },
    );
  }

  Map<String, String> _prepareHeaders(
    Map<String, String>? headers, {
    MediaType? contentType,
  }) {
    final h = <String, String>{
      'Accept': 'application/json',
      if (contentType != null)
        'Content-Type': '${contentType.type}/${contentType.subtype}',
      ...?headers,
    };

    // Default Content-Type for JSON if
    //none specified and you'll send a JSON-able body.
    // We'll set it lazily in _applyBody if needed.
    return h;
  }

  Future<http.Response> _sendRequest({
    required String method,
    required Uri uri,
    required Map<String, String> headers,
    required Duration timeout,
    dynamic body,
  }) async {
    final req = http.Request(method.toUpperCase(), uri)
      ..headers.addAll(headers);

    _applyBody(req, body);

    final streamed = await _client.send(req).timeout(timeout);
    return http.Response.fromStream(streamed);
  }

  void _applyBody(http.Request req, dynamic body) {
    // Never attach a body to GET/HEAD
    if ((req.method == 'GET' || req.method == 'HEAD') || body == null) return;

    if (body is String) {
      // Respect caller's string + ensure Content-Type exists
      req.headers.putIfAbsent('Content-Type', () => 'application/json');
      req.body = body;
    } else if (body is List<int>) {
      req.bodyBytes = body;
      req.headers.putIfAbsent('Content-Type', () => 'application/octet-stream');
    } else if (body is Map || body is List) {
      // JSON-encode common types
      req.headers.putIfAbsent('Content-Type', () => 'application/json');
      req.body = jsonEncode(body);
    } else if (body is Map<String, String>) {
      // If caller truly wants x-www-form-urlencoded,
      //pass content-type explicitly
      // or we’ll default to JSON above. To force form, wrap in FormBody(body).
      req.headers.putIfAbsent('Content-Type', () => 'application/json');
      req.body = jsonEncode(body);
    } else {
      // Fallback: attempt toString
      req.headers
          .putIfAbsent('Content-Type', () => 'text/plain; charset=utf-8');
      req.body = body.toString();
    }
  }

  void _throwOnHttpError(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) return;

    final message = _extractErrorMessage(res);
    throw ApiException(
      message,
      statusCode: res.statusCode,
      details: _tryDecodeJson(res.body),
    );
  }

  Future<http.Response> _refreshTokenAndRetry({
    required String method,
    required Uri uri,
    required Map<String, String> headers,
    required dynamic body,
    required Duration timeout,
  }) async {
    final newAccess = await _refreshAccessTokenLocked();
    if (newAccess == null) {
      // Already cleared by refresh
      throw const RefreshTokenException('Refresh token expired');
    }

    // Update header and retry once
    final retryHeaders = Map<String, String>.from(headers)
      ..['Authorization'] = 'Bearer $newAccess';

    final retried = await _sendRequest(
      method: method,
      uri: uri,
      headers: retryHeaders,
      body: body,
      timeout: timeout,
    );

    return retried;
  }

  /// Guarantees only one refresh request at a time. Others await it.
  Future<String?> _refreshAccessTokenLocked() async {
    // If a refresh is ongoing, await it
    if (_refreshCompleter != null) {
      await _refreshCompleter!.future;
      return _tokenRepository.getAccessToken();
    }

    _refreshCompleter = Completer<void>();
    try {
      final refreshToken = await _tokenRepository.getRefreshToken();
      if (refreshToken == null) {
        await _tokenRepository.clearTokens();
        throw const RefreshTokenException('Refresh token not found');
      }

      final refreshUri = _buildUri(refreshEndpoint, null);
      final res = await _client
          .post(
            refreshUri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({'refresh': refreshToken}),
          )
          .timeout(_defaultTimeout);

      if (res.statusCode == 200) {
        final json = _tryDecodeJson(res.body) ?? {};
        final newAccess = (json['access'] ?? json['access_token'])?.toString();
        if (newAccess == null) {
          throw ApiException(
            'Refresh succeeded but access token missing',
            statusCode: 200,
          );
        }
        await _tokenRepository.saveAccessToken(newAccess);
        _refreshCompleter!.complete();
        return newAccess;
      } else if (res.statusCode == 401) {
        await _tokenRepository.clearTokens();
        _refreshCompleter!.complete();
        return null;
      } else {
        final msg = _extractErrorMessage(res);
        _refreshCompleter!.complete();
        throw ApiException(
          'Failed to refresh token: $msg',
          statusCode: res.statusCode,
        );
      }
    } catch (e) {
      // Ensure waiters are released
      _refreshCompleter!.complete();
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }

  // ---- Helpers --------------------------------------------------------------

  Map<String, dynamic>? _tryDecodeJson(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
      return {'data': decoded};
    } catch (_) {
      return null;
    }
  }

  String _extractErrorMessage(http.Response res) {
    // Friendly message extraction for DRF/typical backends
    final code = res.statusCode;
    final data = _tryDecodeJson(res.body);

    var fallback = 'Something went wrong.';
    if (code >= 500) fallback = 'Server error. Please try again later.';
    if (code == 404) fallback = 'Not found.';
    if (code == 403) fallback = 'Forbidden.';
    if (code == 401) fallback = 'Unauthorized.';

    if (data == null) return fallback;

    // Common DRF shapes:
    // {"detail": "..."} or {"non_field_errors": ["..."]} or {"field": ["..."]}
    if (data['detail'] is String) return data['detail'] as String;
    if (data['message'] is String) return data['message'] as String;
    if (data['error'] is String) return data['error'] as String;

    for (final entry in data.entries) {
      final v = entry.value;
      if (v is List && v.isNotEmpty && v.first is String) {
        return v.first as String;
      }
      if (v is String && v.isNotEmpty) return v;
    }

    return fallback;
  }

  MediaType? _guessMediaTypeFromPath(String path) {
    final ext = p.extension(path).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return MediaType('image', 'jpeg');
      case '.png':
        return MediaType('image', 'png');
      case '.gif':
        return MediaType('image', 'gif');
      case '.pdf':
        return MediaType('application', 'pdf');
      default:
        return null;
    }
  }
}
