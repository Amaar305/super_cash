import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';

abstract interface class CardRemoteDataSource {
  Future<CardFeeSettings> getCardFeeSettings();
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final AuthClient apiClient;

  const CardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CardFeeSettings> getCardFeeSettings() async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'virtual_cards/settings/',
    );
    Map<String, dynamic> res = jsonDecode(response.body);
    if (response.statusCode != 200) {
      final message = extractErrorMessage(res);
      throw ServerException(message);
    }
 
    return CardFeeSettings.fromJson(res['data'] as Map<String, dynamic>);
  }
}
