import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/features/auth/referral_type/domain/entities/entities.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class ReferralTypeRemoteDataSource {
  Future<ReferralTypeResult> fetchCompains();
  Future<ReferralTypeEnrolResult> enrollCompain({
    required String campaignId,
  });
}

class ReferralTypeRemoteDataSourceImpl implements ReferralTypeRemoteDataSource {
  ReferralTypeRemoteDataSourceImpl({required this.apiClient});

  final AuthClient apiClient;

  static const _campaignsPath = 'referrals/campaigns/';
  static const _enrollPath = 'referrals/enroll/';

  @override
  Future<ReferralTypeResult> fetchCompains() async {
    try {
      final response = await apiClient.request(
        method: 'GET',
        path: _campaignsPath,
      );

      final decoded = _decodeToMap(response.body);
      return ReferralTypeResult.fromJson(decoded);
    } on RefreshTokenException catch (_) {
      rethrow;
    } on ApiException catch (e) {
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid response from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReferralTypeEnrolResult> enrollCompain({
    required String campaignId,
  }) async {
    try {
      final response = await apiClient.request(
        method: 'POST',
        path: _enrollPath,
        body: jsonEncode({'campaign_id': campaignId}),
      );

      final decoded = _decodeToMap(response.body);
      return ReferralTypeEnrolResult.fromJson(decoded);
    } on RefreshTokenException catch (_) {
      rethrow;
    } on ApiException catch (e) {
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid response from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Map<String, dynamic> _decodeToMap(String source) {
    if (source.isEmpty) return <String, dynamic>{};

    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return Map<String, dynamic>.from(decoded);

    throw FormatException('Expected JSON object.');
  }
}
