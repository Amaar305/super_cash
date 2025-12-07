import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/device/device_info.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/auth/register/register.dart';

abstract interface class RegisterRemoteDataSource {
  Future<AuthResponse> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    String? referral,
  });
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final AuthClient apiClient;
  final Fingerprint fingerprint;

  RegisterRemoteDataSourceImpl({
    required this.apiClient,
    required this.fingerprint,
  });
  @override
  Future<AuthResponse> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    String? referral,
  }) async {
    try {
      final payload = await fingerprint.collect();
      final body = jsonEncode({
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        'password2': confirmPassword,
        'phone_number': phone,
        ...payload,
        if (referral != null) 'referral_code': referral,
      });
      final res = await apiClient.request(
        method: 'POST',
        path: 'auth/register/',
        body: body,
      );

      final decoded = jsonDecode(res.body);
      if (decoded is Map<String, dynamic>) {
        return AuthResponse(
          user: AppUser.fromMap(decoded),
          message: decoded['message']?.toString(),
        );
      }

      throw ServerException('Unexpected response format.');
    } on ApiException catch (e) {
      // Non-2xx with server-provided message already extracted by AuthClient
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid JSON from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
