import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/features/referal/referal.dart';
import 'package:token_repository/token_repository.dart';

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
    try {
      final request = await apiClient.request(
        method: 'POST',
        path: 'referrals/claim/',
        body: jsonEncode({
          'referral_user_ids': refereeIds,
          'idempotency_key': idms,
        }),
      );

      if (request.statusCode != 200 || request.statusCode != 201) {
        throw ServerException('Something went wrong. Try again later.');
      }

      return ReferralResultModel.fromJson(request.body);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ReferralUserModel>> fetchMyReferrals() async {
    try {
      final request = await apiClient.request(
        method: 'GET',
        path: 'referrals/mine/',
        body: jsonEncode({}),
      );

      if (request.statusCode != 200 || request.statusCode != 201) {
        throw ServerException('Something went wrong. Try again later.');
      }

      final response = jsonDecode(request.body) as List;

      return response.map((e) => ReferralUserModel.fromJson(e)).toList();
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
