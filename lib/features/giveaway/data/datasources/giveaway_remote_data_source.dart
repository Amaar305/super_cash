import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

abstract interface class GiveawayRemoteDataSource {
  Future<List<Giveaway>> getGiveaways();
  Future<List<GiveawayType>> getGiveawayTypes();
  Future<List<AirtimeGiveawayPin>> getAirtimeGiveawayPins();

  Future<GiveawayEligibilityResult> checkGiveawayEligibility({
    required String giveawayTypeId,
  });

  Future<AirtimeGiveawayPin> claimGiveaway({
    required String giveawayTypeId,
    required String planid,
  });

  Future<List<GiveawayHistory>> getHistories();

  Future<List<GiveawayWinner>> getWinners();
}

class GiveawayRemoteDataSourceImpl implements GiveawayRemoteDataSource {
  final AuthClient authClient;

  const GiveawayRemoteDataSourceImpl({required this.authClient});

  @override
  Future<List<AirtimeGiveawayPin>> getAirtimeGiveawayPins() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'giveaway/airtime-pins/',
    );

    final decoded = jsonDecode(response.body);

    final pinsJson = decoded is List
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as List<dynamic>? ?? [];

    return pinsJson
        .map((e) => AirtimeGiveawayPin.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<GiveawayEligibilityResult> checkGiveawayEligibility({
    required String giveawayTypeId,
  }) async {
    final response = await authClient.request(
      method: 'GET',
      path: 'giveaway/check-giveaway-eligibility/',
      queryParameters: {'giveaway_type_id': giveawayTypeId},
    );

    final decoded = jsonDecode(response.body);
    final data = decoded is Map<String, dynamic>
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as Map<String, dynamic>? ??
              ['data'];
    ['data'];

    if (data is Map<String, dynamic>) {
      return GiveawayEligibilityResult.fromJson(data);
    }

    return GiveawayEligibilityResult.fromJson(decoded);
  }

  @override
  Future<AirtimeGiveawayPin> claimGiveaway({
    required String giveawayTypeId,
    required String planid,
  }) async {
    final body = jsonEncode({
      'giveaway_type_id': giveawayTypeId,
      'plan_id': planid,
    });

    final response = await authClient.request(
      method: 'POST',
      path: 'giveaway/claim-giveaway/',
      body: body,
    );

    final decoded = jsonDecode(response.body);

    final data = decoded is Map<String, dynamic>
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as Map<String, dynamic>? ??
              ['data'];

    if (data is Map<String, dynamic>) {
      return AirtimeGiveawayPin.fromJson(data);
    }

    return AirtimeGiveawayPin.fromJson(decoded);
  }

  @override
  Future<List<GiveawayHistory>> getHistories() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'giveaway/histories/',
    );

    final decoded = jsonDecode(response.body);

    final historiesJson = decoded is List
        ? decoded
        : decoded['data'] as List<dynamic>? ?? [];

    return historiesJson
        .map((e) => GiveawayHistory.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<GiveawayType>> getGiveawayTypes() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'giveaway/giveaway-types/',
    );

    final decoded = jsonDecode(response.body) as List<dynamic>;

    return decoded
        .map((e) => GiveawayType.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Giveaway>> getGiveaways() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'giveaway/upcoming-giveaways/',
    );

    final decoded = jsonDecode(response.body) as List<dynamic>;

    return decoded
        .map((e) => Giveaway.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<GiveawayWinner>> getWinners() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'giveaway/winners/',
    );

    final decoded = jsonDecode(response.body) as List<dynamic>;

    return decoded
        .map((e) => GiveawayWinner.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
