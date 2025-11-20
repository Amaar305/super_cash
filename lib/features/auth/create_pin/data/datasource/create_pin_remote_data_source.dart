import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class CreatePinRemoteDataSource {
  Future<Map> createTransactinPin(String pin);
}

class CreatePinRemoteDataSourceImpl implements CreatePinRemoteDataSource {
  final AuthClient apiClient;

  CreatePinRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<Map> createTransactinPin(String pin) async {
    try {
      // final response = await setTransactionPin(pin: pin);
      // final AuthClient authClient;

      final response = await apiClient.request(
        method: 'POST',
        path: 'transaction/set-transaction-pin/',
        body: jsonEncode({'pin': pin}),
      );

      Map res = jsonDecode(response.body);

      if (!res.containsKey('message')) {
        throw ServerException(response.toString());
      }

      return res;
    } on RefreshTokenException catch (e) {
      // Bubble up so the app can force re-login if needed
      throw ServerException(e.message);
    } on ApiException catch (e) {
      // Non-2xx with server-provided message already extracted by AuthClient
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid JSON from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
