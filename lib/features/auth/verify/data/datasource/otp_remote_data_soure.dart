import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class OtpRemoteDataSoure {
  Future<AppUser> verifyOTP(String otp, String email);
  Future<void> requestOTP(String email);
}

class OtpRemoteDataSoureImpl implements OtpRemoteDataSoure {
  final AuthClient apiClient;

  OtpRemoteDataSoureImpl({required this.apiClient});

  @override
  Future<AppUser> verifyOTP(String otp, String email) async {
    try {
      final body = jsonEncode({
        "email": email,
        "purpose": "verify_email",
        "code": otp,
      });
      final response = await apiClient.request(
        method: 'POST',
        path: 'auth/otp/confirm/',
        body: body,
      );

      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return AppUser.fromMap(decoded);
      }

      throw ServerException('Unexpected response format.');
    } on RefreshTokenException catch (e) {
      // Bubble up so the app can force re-login if needed
      throw ServerException(e.message);
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

  @override
  Future<void> requestOTP(String email) async {
    try {
      final body = jsonEncode({'email': email, 'purpose': 'verify_email'});
      final response = await apiClient.request(
        method: 'POST',
        path: 'auth/otp/send/',
        body: body,
      );
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        if (decoded.containsKey('status') && decoded['status'] == 'fail') {
          throw ServerException((decoded['message']));
        }
        return;
      }
    } on RefreshTokenException catch (e) {
      // Bubble up so the app can force re-login if needed
      throw ServerException(e.message);
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
