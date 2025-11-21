import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';

import '../../manage_beneficiary.dart';

abstract interface class BeneficiaryRemoteDataSource {
  Future<BeneficiaryResponse> fetchBeneficiary(int page);
  Future<Beneficiary> saveBeneficiary({
    required String name,
    required String phone,
    required String network,
  });
  Future<Beneficiary> updateBeneficiary({
    required String id,
    String? name,
    String? phone,
    String? network,
  });
  Future<void> deleteBeneficiary({required String id});
}

class BeneficiaryRemoteDataSourceImpl implements BeneficiaryRemoteDataSource {
  final AuthClient apiClient;
  const BeneficiaryRemoteDataSourceImpl(this.apiClient);

  @override
  Future<void> deleteBeneficiary({required String id}) async {
    await apiClient.request(method: 'DELETE', path: 'vtu/beneficiary/$id/');
  }

  @override
  Future<BeneficiaryResponse> fetchBeneficiary(int page) async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'vtu/beneficiaries/?page=$page',
    );

    Map<String, dynamic> res = jsonDecode(response.body);
    return BeneficiaryResponse.fromMap(res);
  }

  @override
  Future<Beneficiary> saveBeneficiary({
    required String name,
    required String phone,
    required String network,
  }) async {
    final response = await apiClient.request(
      method: 'POST',
      path: 'vtu/beneficiaries/',
      body: jsonEncode({
        'name': name,
        'phone': phone,
        'network': network.toLowerCase(),
      }),
    );
    Map<String, dynamic> res = jsonDecode(response.body);
    logI(res);
    return Beneficiary.fromMap(res);
  }

  @override
  Future<Beneficiary> updateBeneficiary({
    required String id,
    String? name,
    String? phone,
    String? network,
  }) async {
    final response = await apiClient.request(
      method: 'PATCH',
      path: 'vtu/beneficiary/$id/',
      body: jsonEncode({
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (network != null) 'network': network.toLowerCase(),
      }),
    );

    Map<String, dynamic> res = jsonDecode(response.body);
    return Beneficiary.fromMap(res);
  }
}
