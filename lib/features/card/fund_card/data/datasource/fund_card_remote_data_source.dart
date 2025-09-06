import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class FundCardRemoteDataSource {
  Future<TransactionResponse> fundCard({
    required String amount,
    required String cardId,
  });
}

class FundCardRemoteDataSourceImpl implements FundCardRemoteDataSource {
  final AuthClient apiClient;

  FundCardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<TransactionResponse> fundCard({
    required String amount,
    required String cardId,
  }) async {
    try {
      final response = await apiClient.request(
        method: 'POST',
        path: 'card/card-fund/',
        body: jsonEncode({'amount': amount, 'card_id': cardId}),
      );
      Map<String, dynamic> res = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);

        throw ServerException(message);
      }

      return TransactionResponse.fromJson(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
