import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';

abstract interface class CreatePinRemoteDataSource {
  Future<Map> createTransactinPin(String pin);
}

class CreatePinRemoteDataSourceImpl implements CreatePinRemoteDataSource {
  final AuthClient apiClient;

  CreatePinRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<Map> createTransactinPin(String pin) async {
    try {
      // final response = await setTransactionPin(pin: pin);
      // final AuthClient authClient;

      final response = await apiClient.request(
        method: 'POST',
        path: 'transaction/set-transaction-pin/',
        body: jsonEncode({'pin': pin}),
      );

      Map res = jsonDecode(response.body);

      if (!res.containsKey('message')) {
        throw ServerException(response.toString());
      }

      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
