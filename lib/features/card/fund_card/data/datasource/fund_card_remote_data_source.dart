import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';

abstract interface class FundCardRemoteDataSource {
  Future<CardOperationResponse> fundCard({
    required String amount,
    required String cardId,
  });
}

class FundCardRemoteDataSourceImpl implements FundCardRemoteDataSource {
  final AuthClient apiClient;

  FundCardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CardOperationResponse> fundCard({
    required String amount,
    required String cardId,
  }) async {
    final response = await apiClient.request(
      method: 'POST',
      path: 'virtual_cards/cards/$cardId/fund/',
      body: jsonEncode({'amount': amount}),
    );
    Map<String, dynamic> res = jsonDecode(response.body);
    if (response.statusCode != 200) {
      final message = extractErrorMessage(res);

      throw ServerException(message);
    }
    return CardOperationResponse.fromJson(res);
  }
}
