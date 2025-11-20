import 'dart:convert';

import 'package:app_client/app_client.dart';

import '../data.dart';

abstract interface class ConfirmTransactionPinRemoteDataSource {
  Future<ConfirmPinModel> veriFyTransactionPin(String pin);
}

class ConfirmTransactionPinRemoteDataSourceImpl
    implements ConfirmTransactionPinRemoteDataSource {
  final AuthClient apiClient;

  ConfirmTransactionPinRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<ConfirmPinModel> veriFyTransactionPin(String pin) async {
    final response = await apiClient.request(
      method: 'POST',
      path: 'transaction/verify-transaction-pin/',
      body: jsonEncode({'pin': pin}),
    );

    Map<String, dynamic> res = jsonDecode(response.body);

    return ConfirmPinModel.fromJson(res);
  }
}
