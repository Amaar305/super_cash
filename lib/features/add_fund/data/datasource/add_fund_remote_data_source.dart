import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';

abstract interface class AddFundRemoteDataSource {
  Future<String> generateAccount({required String bvn});
  Future<List<Account>> fetchBankAccounts();
}

class AddFundRemoteDataSourceImpl implements AddFundRemoteDataSource {
  final AuthClient apiClient;

  AddFundRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<String> generateAccount({required String bvn}) async {
    final response = await apiClient.request(
      path: 'accounts/creation/',
      body: jsonEncode({'bvn': bvn}),
      method: 'POST',
    );
    final responseBody = jsonDecode(response.body);
    return responseBody['response']['message'] as String? ??
        'Account creation sucessfully';
  }

  @override
  Future<List<Account>> fetchBankAccounts() async {
    // Simulate fetching bank accounts from a remote source.
    await Future.delayed(Duration(seconds: 2));
    return [];
  }
}
