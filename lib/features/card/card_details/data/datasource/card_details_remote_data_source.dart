import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';

abstract interface class CardDetailsRemoteDataSource {
  Future<CardDetails> getFullCardDetails(String cardId);
  Future<CardActionResponse> freezeCard(String cardId);
  Future<CardActionResponse> unfreezeCard(String cardId);
  Future<CardActionResponse> deleteCard(String cardId);
}

class CardDetailsRemoteDataSourceImpl implements CardDetailsRemoteDataSource {
  final AuthClient apiClient;

  CardDetailsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CardDetails> getFullCardDetails(String cardId) async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'virtual_cards/cards/$cardId/',
    );

    Map<String, dynamic> res = jsonDecode(response.body);

    if (response.statusCode != 200) {
      final message = extractErrorMessage(res);
      throw ServerException(message);
    }

    return CardDetails.fromJson(res['data']);
  }

  Future<CardActionResponse> _performAction(
    String cardId,
    String action,
  ) async {
    final response = await apiClient.request(
      method: 'POST',
      path: 'virtual_cards/cards/$cardId/$action/',
    );

    Map<String, dynamic> res = jsonDecode(response.body);

    if (response.statusCode != 200) {
      final message = extractErrorMessage(res);
      throw ServerException(message);
    }

    return CardActionResponse.fromJson(res);
  }

  @override
  Future<CardActionResponse> freezeCard(String cardId) {
    return _performAction(cardId, 'freeze');
  }

  @override
  Future<CardActionResponse> unfreezeCard(String cardId) {
    return _performAction(cardId, 'unfreeze');
  }

  @override
  Future<CardActionResponse> deleteCard(String cardId) {
    return _performAction(cardId, 'delete');
  }
}
