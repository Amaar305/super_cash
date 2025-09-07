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
        "otp": otp,
        "password": password,
        "confirm_password": confirmPassword,
      });
      final request = await authClient.request(
        method: 'POST',
        path: 'auth/reset-password/',
        body: body,
        withToken: false,
      );
      final response = jsonDecode(request.body);

      if (response.containsKey('status') && response['status'] != 'success') {
        throw ServerException(response['message']);
      }
      if (response.containsKey('non_field_errors') &&
          response['non_field_errors'].runtimeType == List) {
        throw ServerException(response['non_field_errors'][0]);
      }
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map> requestOtpWithEmail(String email) async {
    try {
      final body = jsonEncode({'email': email});
      final request = await authClient.request(
        method: 'POST',
        path: 'auth/send-otp/',
        body: body,
        withToken: false,
      );
      final response = jsonDecode(request.body);

      if (response.containsKey('status') && response['status'] != 'success') {
        throw ServerException(response['message']);
      }

      if (response.containsKey('non_field_errors') &&
          response['non_field_errors'].runtimeType == List) {
        throw ServerException(response['non_field_errors'][0]);
      }

      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
