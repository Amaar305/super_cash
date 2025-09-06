import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class ChangeCardPinRemoteDataSource {
  Future<Map<String, dynamic>> changeCardPin({
    required String pin,
    required String cardId,
  });
}

class ChangeCardPinRemoteDataSourceImpl
    implements ChangeCardPinRemoteDataSource {
  final AuthClient apiClient;

  ChangeCardPinRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Map<String, dynamic>> changeCardPin({
    required String pin,
    required String cardId,
  }) async {
    try {
      final response = await apiClient.request(
        method: 'POST',
        path: 'card/card-pin-update/',
        body: jsonEncode({'card_id': cardId, 'pin': pin}),
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
