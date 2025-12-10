import 'dart:convert';

import 'package:app_client/app_client.dart';

abstract interface class CreateCardRemoteDataSource {
  Future<Map<String, dynamic>> createVirtualCard({
    required String pin,
    required String cardLimit,
    required String amount,
    required String cardBrand,
  });
}

class CreateCardRemoteDataSourceImpl implements CreateCardRemoteDataSource {
  final AuthClient apiClient;

  CreateCardRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<Map<String, dynamic>> createVirtualCard({
    required String pin,
    required String cardLimit,
    required String amount,
    required String cardBrand,
  }) async {
    final response = await apiClient.request(
      method: 'POST',
      path: 'card/card-creation/',
      body: jsonEncode({
        'amount': amount,
        'pin': pin,
        'card_limit': cardLimit,
        'card_brand': cardBrand,
      }),
    );
    Map<String, dynamic> res = jsonDecode(response.body);

    return res;
  }
}
