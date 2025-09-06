import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class CardDetailsRemoteDataSource {
  Future<CardDetails> getFullCardDetails(String cardId);
  Future<Map<String, dynamic>> freezeCard(String cardId);
}

class CardDetailsRemoteDataSourceImpl implements CardDetailsRemoteDataSource {
  final AuthClient apiClient;

  CardDetailsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CardDetails> getFullCardDetails(String cardId) async {
    try {
      final response = await apiClient.request(
        method: 'GET',
        path: 'card/details/$cardId',
        body: jsonEncode({}),
      );

      Map<String, dynamic> res = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);
        throw ServerException(message);
      }

      return CardDetails.fromJson(res['data']);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> freezeCard(String cardId) async {
    try {
      final response = await apiClient.request(
        method: 'PATCH',
        path: 'card/card-freeze/',
        body: jsonEncode({'card_id': cardId}),
      );

      Map<String, dynamic> res = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);
        throw ServerException(message);
      }

      return res;
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
