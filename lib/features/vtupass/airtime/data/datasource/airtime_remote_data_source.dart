import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';

abstract interface class AirtimeRemoteDataSource {
  Future<TransactionResponse> buyAirtime({
    required String mobileNumber,
    required String amount,
    required String network,
  });
}

class AirtimeRemoteDataSourceImpl implements AirtimeRemoteDataSource {
  final AuthClient authClient;

  AirtimeRemoteDataSourceImpl({required this.authClient});
  @override
  Future<TransactionResponse> buyAirtime({
    required String mobileNumber,
    required String amount,
    required String network,
  }) async {
    final body = jsonEncode({
      "amount": amount,
      "network": network,
      "phone": mobileNumber,
    });
    final response = await authClient.request(
      method: 'POST',
      path: 'vtu/buy-airtime/',
      body: body,
    );

    Map res = jsonDecode(response.body);

    return TransactionResponse.fromJson(res as Map<String, dynamic>);
  }
}
