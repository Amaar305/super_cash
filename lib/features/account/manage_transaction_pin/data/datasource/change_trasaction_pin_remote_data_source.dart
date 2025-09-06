import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class ChangeTransactionPinRemoteDataSource {
  Future<String> changeTransactionPin({
    required String currentPin,
    required String newPin,
    required String cofirmPin,
  });

  Future<Map> requestOtpWithEmail(String email);

  Future<Map> resetTransactionPin({
    required String email,
    required String otp,
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
    try {
      final body = jsonEncode({
        "old_pin": currentPin,
        "pin": newPin,
        "confirm_pin": cofirmPin,
      });
      final request = await apiClient.request(
        method: 'PUT',
        path: 'transaction/transaction-pin/change/',
        body: body,
        // withToken: false,
      );
      final response = jsonDecode(request.body);

      if (response.containsKey('pin') && response['pin'] is List) {
        throw ServerException(response['pin'][0].toString());
      }
      if (response.containsKey('confirm_pin') &&
          response['confirm_pin'] is List) {
        throw ServerException(response['confirm_pin'][0].toString());
      }
      if (response.containsKey('old_pin') && response['old_pin'] is List) {
        throw ServerException(response['old_pin'][0].toString());
      }
      if (response.containsKey('non_field_errors') &&
          response['non_field_errors'].runtimeType == List) {
        throw ServerException(response['non_field_errors'][0]);
      }
      if (response.containsKey('details') &&
          response['details'].runtimeType == List) {
        throw ServerException(response['details'][0].toString());
      }
      return response['message'];
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
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
      print(request.statusCode);

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
    required String email,
    required String otp,
    required String pin,
    required String confirmPin,
  }) async {
    try {
      final body = jsonEncode({
        "email": email,
        "otp": otp,
        "pin": pin,
        "confirm_pin": confirmPin,
      });
      final request = await apiClient.request(
        method: 'POST',
        path: 'transaction/transaction-pin/reset/confirm/',
        body: body,
        // withToken: false,
      );
      final response = jsonDecode(request.body);

      if (response.containsKey('email') && response['email'] is List) {
        throw ServerException(response['email'][0].toString());
      }
      if (response.containsKey('non_field_errors') &&
          response['non_field_errors'].runtimeType == List) {
        throw ServerException(response['non_field_errors'][0]);
      }
      if (response.containsKey('details') &&
          response['details'].runtimeType == List) {
        throw ServerException(response['details'][0].toString());
      }
      return response;
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
