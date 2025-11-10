import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';

abstract interface class ForgotPasswordRemoteDataSource {
  Future<Map> requestOtpWithEmail(String email);
  Future<Map> changePassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  });
}

class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSource {
  final AuthClient authClient;
  const ForgotPasswordRemoteDataSourceImpl({required this.authClient});

  @override
  Future<Map> changePassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final body = jsonEncode({
        "email": email,
        "code": otp,
        "new_password": password,
        "new_password_confirm": confirmPassword,
      });
      final request = await authClient.request(
        method: 'POST',
        path: 'auth/password/reset/otp/confirm/',
        body: body,
        withToken: false,
      );
      final decoded = jsonDecode(request.body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      throw ServerException('Unexpected response format.');
    } on ApiException catch (e) {
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
  Future<Map> requestOtpWithEmail(String email) async {
    try {
      final body = jsonEncode({
        'email': email,
        'purpose': 'password_reset_otp',
      });
      final request = await authClient.request(
        method: 'POST',
        path: 'auth/password/reset/otp/request/',
        body: body,
        withToken: false,
      );
      final decoded = jsonDecode(request.body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      throw ServerException('Unexpected response format.');
    } on ApiException catch (e) {
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
