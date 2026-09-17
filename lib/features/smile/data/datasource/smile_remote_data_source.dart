import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/smile/data/models/models.dart';

abstract interface class SmileRemoteDataSource {
  Future<SmilePlanResponseModel> fetchPlans();

  Future<SmileVerificationResultModel> verifyEmail({required String email});

  Future<TransactionResponse> purchase({
    required String email,
    required String accountId,
    required String variationCode,
    required String phone,
  });

  Future<SmileTransactionStatusModel> queryTransactionStatus({
    required String reference,
  });
}

class SmileRemoteDataSourceImpl implements SmileRemoteDataSource {
  final AuthClient authClient;

  const SmileRemoteDataSourceImpl({required this.authClient});

  static const _plansPath = 'smile/plans/';
  static const _verifyEmailPath = 'smile/verify-email/';
  static const _purchasePath = 'smile/purchase/';

  @override
  Future<SmilePlanResponseModel> fetchPlans() async {
    final response = await authClient.request(method: 'GET', path: _plansPath);

    final res = jsonDecode(response.body) as Map<String, dynamic>;
    return SmilePlanResponseModel.fromJson(res);
  }

  @override
  Future<SmileVerificationResultModel> verifyEmail({
    required String email,
  }) async {
    final response = await authClient.request(
      method: 'POST',
      path: _verifyEmailPath,
      body: jsonEncode({'email': email}),
    );

    final res = jsonDecode(response.body) as Map<String, dynamic>;
    return SmileVerificationResultModel.fromJson(res);
  }

  @override
  Future<TransactionResponse> purchase({
    required String email,
    required String accountId,
    required String variationCode,
    required String phone,
  }) async {
    final response = await authClient.request(
      method: 'POST',
      path: _purchasePath,
      body: jsonEncode({
        'email': email,
        'account_id': accountId,
        'variation_code': variationCode,
        'phone': phone,
      }),
    );

    final res = jsonDecode(response.body) as Map<String, dynamic>;
    return TransactionResponse.fromJson(res);
  }

  @override
  Future<SmileTransactionStatusModel> queryTransactionStatus({
    required String reference,
  }) async {
    final response = await authClient.request(
      method: 'GET',
      path: 'smile/transactions/$reference/status/',
    );

    final res = jsonDecode(response.body) as Map<String, dynamic>;
    return SmileTransactionStatusModel.fromJson(res);
  }
}
