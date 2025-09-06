import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class CardWithdrawRemoteDataSource {
  Future<TransactionResponse> cardWithdraw({
    required String amount,
    required String cardId,
  });
  Future<Wallet> fetchBalance();
}

class CardWithdrawRemoteDataSourceImpl implements CardWithdrawRemoteDataSource {
  final AuthClient apiClient;

  CardWithdrawRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<TransactionResponse> cardWithdraw({
    required String amount,
    required String cardId,
  }) async {
    try {
      final response = await apiClient.request(
        method: 'POST',
        path: 'card/card-unload/',
        body: jsonEncode({"card_id": cardId, "amount": amount}),
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

  @override
  Future<Wallet> fetchBalance() async {
    try {
      final response = await apiClient.request(
        method: 'GET',
        path: 'wallet/user-wallet/',
        body: jsonEncode({}),
      );

      Map<String, dynamic> res = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);

        throw ServerException(message);
      }

      return Wallet.fromMap(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
