import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class CardRemoteDataSource {
  Future<DollarRate> getDollarRate();
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final AuthClient apiClient;

  const CardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<DollarRate> getDollarRate() async {
    try {
      final response = await apiClient.request(
        method: 'GET',
        path: 'card/dollar-rate/',
       
      );
      Map<String, dynamic> res = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);

        throw ServerException(message);
      }

      return DollarRate.fromJson(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
