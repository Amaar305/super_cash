import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class ChangePasswordRemoteDataSource {
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}

class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  final AuthClient apiClient;

  const ChangePasswordRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await apiClient.request(
        method: 'PATCH',
        path: 'auth/password-change/',
        body: jsonEncode({
          "old_password": currentPassword,
          "password": newPassword,
          "confirm_password": confirmPassword,
        }),
      );
      if (response.statusCode == 500 || response.statusCode == 404) {
        throw ServerException('Something went wrong. Try again later.');
      } else if (response.statusCode != 200) {
        final message = extractErrorMessage(jsonDecode(response.body));
        throw ServerException(message);
      }
      final res = jsonDecode(response.body);
      return res['message'];
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
