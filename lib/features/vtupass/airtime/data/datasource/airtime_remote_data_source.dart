import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class AirtimeRemoteDataSource {
  Future<TransactionResponse> buyAirtime({
    required String mobileNumber,
    required String amount,
    required String network,
  });
}

class AirtimeRemoteDataSourceImpl implements AirtimeRemoteDataSource {
  final AuthClient authClient;

  AirtimeRemoteDataSourceImpl({required this.authClient});
  @override
  Future<TransactionResponse> buyAirtime({
    required String mobileNumber,
    required String amount,
    required String network,
  }) async {
    try {
      final body = jsonEncode({
        "amount": amount,
        "network": network,
        "phone": mobileNumber,
      });
      final response = await authClient.request(
        method: 'POST',
        path: 'vtu/buy-airtime/',
        body: body,
      );

      Map res = jsonDecode(response.body);
      if (res.containsKey('non_field_errors') &&
          res['non_field_errors'].runtimeType == String) {
        throw ServerException(res['non_field_errors']);
      }
      if (res.containsKey('non_field_errors') &&
          res['non_field_errors'].runtimeType == List) {
        throw ServerException(res['non_field_errors'][0]);
      }

      if (res.containsKey('detail')) {
        throw ServerException(res['detail']);
      }

      if (res.containsKey('status') && res['status'] == 'fail') {
        throw ServerException(res['message']);
      } else if (res.containsKey('status') &&
          res['status'].runtimeType == List &&
          res['status'][0] == 'fail') {
        throw ServerException(res['message'][0]);
      }

      return TransactionResponse.fromJson(res as Map<String, dynamic>);
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
