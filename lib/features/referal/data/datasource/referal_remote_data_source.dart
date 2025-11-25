import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/referal/referal.dart';

abstract interface class ReferalRemoteDataSource {
  Future<List<ReferralUserModel>> fetchMyReferrals();
  Future<ReferralResultModel> claimMyRewards({
    required List<String> refereeIds,
    required String idms,
  });
}

class ReferalRemoteDataSourceImpl implements ReferalRemoteDataSource {
  final AuthClient apiClient;

  ReferalRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ReferralResultModel> claimMyRewards({
    required List<String> refereeIds,
    required String idms,
  }) async {
    final request = await apiClient.request(
      method: 'GET',
      path: 'referrals/stats/',
    );
    // logI(request.body);

    return ReferralResultModel.fromJson(request.body);
  }

  @override
  Future<List<ReferralUserModel>> fetchMyReferrals() async {
    final request = await apiClient.request(
      method: 'GET',
      path: 'referrals/mine/',
    );

    final response = jsonDecode(request.body) as List;
    logD(response);

    return response.map((e) => ReferralUserModel.fromMap(e)).toList();
  }
}
