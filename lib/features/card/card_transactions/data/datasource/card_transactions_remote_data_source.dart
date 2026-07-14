import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';

abstract interface class CardTransactionsRemoteDataSource {
  Future<CardTransactionsResponse> fetchCardTransactions({
    required String cardId,
    int? page,
  });
}

class CardTransactionsRemoteDataSourceImpl
    implements CardTransactionsRemoteDataSource {
  final AuthClient apiClient;

  CardTransactionsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CardTransactionsResponse> fetchCardTransactions({
    required String cardId,
    int? page,
    int? limit,
  }) async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'virtual_cards/cards/$cardId/transactions/',
      queryParameters: {
        if (page != null) 'page': page.toString(),
        if (limit != null) 'limit': limit.toString(),
      },
    );

    Map<String, dynamic> res = jsonDecode(response.body);
    return CardTransactionsResponse.fromJson(res);
  }
}
