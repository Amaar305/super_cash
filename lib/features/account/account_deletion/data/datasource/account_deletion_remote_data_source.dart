import 'dart:convert';

import 'package:app_client/app_client.dart';

abstract interface class AccountDeletionRemoteDataSource {
  Future<void> accountDeletionRequested({required String reason});
}

class AccountDeletionRemoteDataSourceImpl
    implements AccountDeletionRemoteDataSource {
  final AuthClient apiClient;

  const AccountDeletionRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<void> accountDeletionRequested({required String reason}) async {
    final body = jsonEncode({"reason": reason});

    await apiClient.request(
      method: 'POST',
      path: 'auth/account/delete/',
      body: body,
    );
  }
}
