import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';
import '../models/electricity_validation_result.dart';

abstract class ElectricityRemoteDataSource {
  Future<ElectricityPlan> getPlans();
  Future<ElectricityValidationResult> validatePlan({
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
      path: 'vtu/electricity-purchase/',
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
  Future<ElectricityValidationResult> validatePlan({
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

    final Map<String, dynamic> res = jsonDecode(response.body);
    logD(res);
    return ElectricityValidationResult.fromJson(res);
  }
}
