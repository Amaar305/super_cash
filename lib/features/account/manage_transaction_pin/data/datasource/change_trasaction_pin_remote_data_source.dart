import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';

abstract interface class ChangeTransactionPinRemoteDataSource {
  Future<String> changeTransactionPin({
    required String currentPin,
    required String newPin,
    required String cofirmPin,
  });

  Future<Map> requestOtpWithEmail(String email);

  Future<Map> resetTransactionPin({
    required String password,
    required String pin,
    required String confirmPin,
  });
}

class ChangeTransactionPinRemoteDataSourceImpl
    implements ChangeTransactionPinRemoteDataSource {
  final AuthClient apiClient;

  const ChangeTransactionPinRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<String> changeTransactionPin({
    required String currentPin,
    required String newPin,
    required String cofirmPin,
  }) async {
    final body = jsonEncode({
      "current_pin": currentPin,
      "new_pin": newPin,
      "confirm_new_pin": cofirmPin,
    });
    final request = await apiClient.request(
      method: 'POST',
      path: 'transaction/change-transaction-pin/',
      body: body,
      // withToken: false,
    );
    final response = jsonDecode(request.body);

    return response['message'];
  }

  @override
  Future<Map> requestOtpWithEmail(String email) async {
    try {
      final body = jsonEncode({'email': email});
      final request = await apiClient.request(
        method: 'POST',
        path: 'transaction/transaction-pin/reset/request/',
        body: body,
        // withToken: false,
      );

      final response = jsonDecode(request.body);

      if (response.containsKey('details') &&
          response['details'].runtimeType == List) {
        throw ServerException(response['details'][0].toString());
      }
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map> resetTransactionPin({
    required String password,
    required String pin,
    required String confirmPin,
  }) async {
    final body = jsonEncode({
      "password": password,
      "new_pin": pin,
      "confirm_new_pin": confirmPin,
    });
    final request = await apiClient.request(
      method: 'POST',
      path: 'transaction/reset-transaction-pin/',
      body: body,
    );
    final response = jsonDecode(request.body);

    return response;
  }
}
