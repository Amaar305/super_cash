import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

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
  }) async {
    try {
      final response = await apiClient.request(
        method: 'GET',
        path: 'card/card-transactions/$cardId/${page ?? 1}/',
        body: jsonEncode({}),
      );

      Map<String, dynamic> res = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);

        throw ServerException(message);
      }
      return CardTransactionsResponse.fromJson(res['data']);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
