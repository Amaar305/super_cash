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
        path: 'accounts/creation/',
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
    } on RefreshTokenException catch (e) {
      // Bubble up so the app can force re-login if needed
      throw ServerException(e.message);
    } on ApiException catch (e) {
      // Non-2xx with server-provided message already extracted by AuthClient e5a9a3cc-0ca8-487b-9036-72060e75cd71
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
  Future<List<Account>> fetchBankAccounts() async {
    // Simulate fetching bank accounts from a remote source.
    await Future.delayed(Duration(seconds: 2));
    return [];
  }
}
