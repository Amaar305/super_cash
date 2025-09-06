import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

import '../data.dart';

abstract interface class ConfirmTransactionPinRemoteDataSource {
  Future<ConfirmPinModel> veriFyTransactionPin(String pin);
}

class ConfirmTransactionPinRemoteDataSourceImpl
    implements ConfirmTransactionPinRemoteDataSource {
  final AuthClient apiClient;

  ConfirmTransactionPinRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<ConfirmPinModel> veriFyTransactionPin(String pin) async {
    try {
      final response = await apiClient.request(
        method: 'POST',
        path: 'transaction/verify-transaction-pin/',
        body: jsonEncode({'pin': pin}),
      );

      Map<String, dynamic> res = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);

        throw ServerException(message);
      }

      return ConfirmPinModel.fromJson(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
