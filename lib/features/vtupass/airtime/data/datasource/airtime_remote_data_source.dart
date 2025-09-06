import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';

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
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
