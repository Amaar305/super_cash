import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

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
    try {
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

      if (response.statusCode != 201) {
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
