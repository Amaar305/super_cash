import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';

abstract interface class DataRemoteDataSource {
  Future<DataPlanResponse> fetchPlans({required String network});

  Future<TransactionResponse> buyDataPlan({
    required String network,
    required String planId,
    required String phoneNumber,
  });
}

class DataRemoteDataSourceImpl implements DataRemoteDataSource {
  final AuthClient authClient;

  DataRemoteDataSourceImpl({required this.authClient});
  @override
  Future<TransactionResponse> buyDataPlan({
    required String network,
    required String planId,
    required String phoneNumber,
  }) async {
    final body = jsonEncode({
      "plan_id": planId,
      "network": network,
      "phone": phoneNumber,
    });

    final response = await authClient.request(
      method: 'POST',
      path: 'vtu/buy-data/',
      body: body,
    );
    Map res = jsonDecode(response.body);

    return TransactionResponse.fromJson(res as Map<String, dynamic>);
  }

  @override
  Future<DataPlanResponse> fetchPlans({required String network}) async {
    final response = await authClient.request(
      method: 'GET',
      path: 'vtu/data-plans/$network/',
    );
    Map res = jsonDecode(response.body);

    return DataPlanResponse.fromJson(res as Map<String, dynamic>);
  }
}
