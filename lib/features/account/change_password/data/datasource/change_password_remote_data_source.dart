import 'dart:convert';

import 'package:app_client/app_client.dart';

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
    final response = await apiClient.request(
      method: 'POST',
      path: 'auth/password/reset/change/',
      body: jsonEncode({
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirm": confirmPassword,
      }),
    );

    final res = jsonDecode(response.body);
    return res['message'] ?? 'Password changed successful';
  }
}
