import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // for MediaType
import 'package:path/path.dart';
import 'package:token_repository/token_repository.dart';

/// {@template app_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
// data/datasources/remote/auth_client.dart
class AuthClient {
  /// {@macro app_client}

  const AuthClient({
    required http.Client client,
    required TokenRepository tokenRepository,
    required String baseUrl,
  })  : _client = client,
        _tokenRepository = tokenRepository,
        _baseUrl = baseUrl;
  final http.Client _client;
  final TokenRepository _tokenRepository;
  final String _baseUrl;

  ///
  Future<http.Response> request({
    required String method,
    required String path,
    bool withToken = true,
    Map<String, String>? headers = const {
      'Content-Type': 'application/json',
    },
    dynamic body,
  }) async {
    // Get access token
    final accessToken = await _tokenRepository.getAccessToken();

    // print(accessToken);

    // Prepare initial headers
    final requestHeaders = Map<String, String>.from(headers ?? {});
    if (accessToken != null && withToken) {
      requestHeaders['Authorization'] = 'Bearer $accessToken';
    }

      // Only apply body if not GET
    // if (method != 'GET' && body != null) {
    //   request.body = body as String;
    // }


    // Make initial request
    final uri = Uri.parse('$_baseUrl/$path');
    final response = await _client.send(
      http.Request(method, uri)
        ..headers.addAll(requestHeaders)
        ..body = body as String,
    );

    // If unauthorized, try to refresh token
    if (response.statusCode == 401 && withToken) {
      return _refreshTokenAndRetry(method, uri, requestHeaders, body);
    }

    return http.Response.fromStream(response);
  }

  /// New: Multipart file upload
  Future<http.Response> multipartRequest({
    required String path,
    required File file,
    String fileField = 'file',
    Map<String, String>? fields,
    bool withToken = true,
    Map<String, String>? headers,
    MediaType? contentType,
  }) async {
    final accessToken = await _tokenRepository.getAccessToken();
    final uri = Uri.parse('$_baseUrl/$path');

    final request = http.MultipartRequest('POST', uri);

    if (withToken && accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    if (headers != null) {
      request.headers.addAll(headers);
    }

    if (fields != null) {
      request.fields.addAll(fields);
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        fileField,
        file.path,
        filename: basename(file.path),
        contentType: contentType ?? MediaType('image', 'jpeg'),
      ),
    );

    final streamedResponse = await request.send();

    // Handle token refresh on 401
    if (streamedResponse.statusCode == 401 && withToken) {
      return _refreshTokenAndRetryMultipart(
        uri,
        file,
        fileField,
        fields,
        headers,
        contentType,
      );
    }

    return http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> _refreshTokenAndRetry(
    String method,
    Uri uri,
    Map<String, String> headers,
    dynamic body,
  ) async {
    final refreshToken = await _tokenRepository.getRefreshToken();

    if (refreshToken == null) {
      throw const RefreshTokenException('Refresh token not found');
    }

    // Request new access token
    final refreshResponse = await _client.post(
      Uri.parse('$_baseUrl/auth/token/refresh/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (refreshResponse.statusCode == 200) {
      final newAccessToken =
          (jsonDecode(refreshResponse.body) as Map)['access'];

      await _tokenRepository.saveAccessToken(newAccessToken as String);

      // Update headers with new token
      headers['Authorization'] = 'Bearer $newAccessToken';

      // Retry original request
      final retryResponse = await _client.send(
        http.Request(method, uri)
          ..headers.addAll(headers)
          ..body = body as String,
      );

      return http.Response.fromStream(retryResponse);
    } else if (refreshResponse.statusCode == 401) {
      // Refresh token expired
      await _tokenRepository.clearTokens();
      throw const RefreshTokenException('Refresh token expired');
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<http.Response> _refreshTokenAndRetryMultipart(
    Uri uri,
    File file,
    String fileField,
    Map<String, String>? fields,
    Map<String, String>? headers,
    MediaType? contentType,
  ) async {
    final refreshToken = await _tokenRepository.getRefreshToken();

    if (refreshToken == null) {
      throw const RefreshTokenException('Refresh token not found');
    }

    final refreshResponse = await _client.post(
      Uri.parse('$_baseUrl/auth/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (refreshResponse.statusCode == 200) {
      final newAccessToken =
          (jsonDecode(refreshResponse.body) as Map)['access'];
      await _tokenRepository.saveAccessToken(newAccessToken as String);

      final retryRequest = http.MultipartRequest('POST', uri);
      retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';

      if (headers != null) retryRequest.headers.addAll(headers);
      if (fields != null) retryRequest.fields.addAll(fields);

      retryRequest.files.add(
        await http.MultipartFile.fromPath(
          fileField,
          file.path,
          filename: basename(file.path),
          contentType: contentType ?? MediaType('image', 'jpeg'),
        ),
      );

      final retryResponse = await retryRequest.send();
      return http.Response.fromStream(retryResponse);
    } else if (refreshResponse.statusCode == 401) {
      await _tokenRepository.clearTokens();
      throw const RefreshTokenException('Refresh token expired');
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
