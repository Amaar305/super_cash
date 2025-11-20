import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';

abstract class ElectricityRemoteDataSource {
  Future<ElectricityPlan> getPlans();
  Future<Map> validatePlan({
    required String billersCode,
    required String serviceID,
    required String type,
  });
  Future<TransactionResponse> buyPlan({
    required String billersCode,
    required String serviceID,
    required String type,
    required String amount,
    required String phone,
  });
}

class ElectricityRemoteDataSourceImpl implements ElectricityRemoteDataSource {
  final AuthClient authClient;

  ElectricityRemoteDataSourceImpl({required this.authClient});

  @override
  Future<TransactionResponse> buyPlan({
    required String billersCode,
    required String serviceID,
    required String type,
    required String amount,
    required String phone,
  }) async {
    final body = jsonEncode({
      "billersCode": billersCode,
      "serviceID": serviceID,
      "variation_code": type,
      "amount": amount,
      "phone": phone,
    });
    final response = await authClient.request(
      method: 'POST',
      path: 'vtu/electricity-purrchase/',
      body: body,
    );

    Map<String, dynamic> res = jsonDecode(response.body);
    return TransactionResponse.fromJson(res);
  }

  @override
  Future<ElectricityPlan> getPlans() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'vtu/get-electricity-plans/',
    );

    Map<String, dynamic> res = jsonDecode(response.body);
    return ElectricityPlan.fromJson(res);
  }

  @override
  Future<Map> validatePlan({
    required String billersCode,
    required String serviceID,
    required String type,
  }) async {
    final body = jsonEncode({
      "billersCode": billersCode,
      "serviceID": serviceID,
      "type": type,
    });
    final response = await authClient.request(
      method: 'POST',
      path: 'vtu/electricity-verification/',
      body: body,
    );

    Map<String, dynamic> res = jsonDecode(response.body);

    return res;
  }
}
