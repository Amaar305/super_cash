import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/error/exception.dart';

abstract class HomeUserRemoteDataSource {
  Future<AppUser> fetchUserDetails();
  Future<HomeSettings> fetchAppSettings({
    required String platform,
    required String version,
    required String versionCode,
  });

  Future<({String message, String status, Account? account})>
  createPalmPayAccount();
}

class HomeUserRemoteDataSourceImpl implements HomeUserRemoteDataSource {
  final AuthClient authClient;

  HomeUserRemoteDataSourceImpl({required this.authClient});

  @override
  Future<AppUser> fetchUserDetails() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'auth/user-details/',
    );

    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return AppUser.fromMap(decoded);
    }
    throw ServerException('Unexpected response format.');
  }

  @override
  Future<HomeSettings> fetchAppSettings({
    required String platform,
    required String version,
    required String versionCode,
  }) async {
    final response = await authClient.request(
      method: 'GET',
      path: 'core/app-settings/',
      queryParameters: {
        'platform': platform,
        'version': version,
        'version_code': versionCode,
      },
    );

    final decoded = jsonDecode(response.body);

    if (decoded is Map<String, dynamic>) {
      if (decoded['data'] is Map<String, dynamic>) {
        return HomeSettings.fromJson(decoded['data'] as Map<String, dynamic>);
      }

      return HomeSettings.fromJson(decoded);
    }
    throw ServerException('Unexpected response format.');
  }

  @override
  Future<({Account? account, String message, String status})>
  createPalmPayAccount() async {
    final response = await authClient.request(
      method: 'POST',
      path: 'accounts/palm-pay-account-creation/',
      body: jsonEncode({'account_type': 'palmpay'}),
    );

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw ServerException('Unexpected response format.');
    }

    final responseData = decoded['response'];
    final data = decoded['data'];
    final accountData = decoded['account'] ?? data ?? responseData?['account'];

    return (
      account: accountData is Map<String, dynamic>
          ? Account.fromMap(accountData)
          : null,
      message:
          decoded['message']?.toString() ??
          responseData?['message']?.toString() ??
          'Account creation sucessfully',
      status:
          decoded['status']?.toString() ??
          responseData?['status']?.toString() ??
          'success',
    );
  }
}
