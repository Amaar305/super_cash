import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class AddFundRemoteDataSource {
  Future<String> generateAccount({required String bvn});
  Future<List<Account>> fetchBankAccounts();
}

class AddFundRemoteDataSourceImpl implements AddFundRemoteDataSource {
  final AuthClient apiClient;

  AddFundRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<String> generateAccount({required String bvn}) async {
    try {
      final response = await apiClient.request(
        path: 'core/account-creation/',
        body: jsonEncode({'bvn': bvn}),
        method: 'POST',
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return responseBody['response']['message'] as String;
      } else {
        final responseBody = jsonDecode(response.body);
        final message = extractErrorMessage(responseBody);
        throw ServerException(message);
      }
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<Account>> fetchBankAccounts() async {
    // Simulate fetching bank accounts from a remote source.
    await Future.delayed(Duration(seconds: 2));
    return [];
  }
}
