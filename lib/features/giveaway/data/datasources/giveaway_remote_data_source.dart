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

  Future<AirtimeGiveawayPin> claimPINGiveaway({
    required String giveawayTypeId,
    required String planid,
  });

  Future<List<GiveawayHistory>> getHistories();

  Future<List<GiveawayWinner>> getWinners();
  Future<List<ProductGiveawayModel>> getProductsGiveaway();
  Future<ProductGiveawayModel> claimProductGiveaway({
    required String productId,
    required String giveawayTypeId,
  });

  Future<ProductClaimAddressModel> addProductDeliveryAddress({
    required String productId,
    required String fullName,
    required String phoneNumber,
    required String address,
  });

  Future<List<DataGiveawayItem>> getDataGiveaways();
  Future<DataGiveawayItem> claimDataGiveaway({
    required String dataId,
    required String giveawayTypeId,
    required String phone,
  });

  Future<List<CashGiveawayItem>> getCashGiveaways();
  Future<CashGiveawayItem> claimCashGiveaway({
    required String cashId,
    required String giveawayTypeId,
  });

  Future<UserCashAccountDetailModel> addCashAccountDetails({
    required String cashId,
    required String accountName,
    required String accountNumber,
    required String bankName,
    String? bankCode,
    String? phoneNumber,
  });
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
  Future<AirtimeGiveawayPin> claimPINGiveaway({
    required String giveawayTypeId,
    required String planid,
  }) async {
    final body = jsonEncode({
      'giveaway_type_id': giveawayTypeId,
      'plan_id': planid,
    });

    final response = await authClient.request(
      method: 'POST',
      path: 'giveaway/claim-pin-giveaway/',
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

  @override
  Future<List<ProductGiveawayModel>> getProductsGiveaway() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'giveaway/products-list/',
    );

    final decoded = jsonDecode(response.body);

    final productsJson = decoded is List
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as List<dynamic>? ?? [];

    return productsJson
        .map((e) => ProductGiveawayModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProductGiveawayModel> claimProductGiveaway({
    required String productId,
    required String giveawayTypeId,
  }) async {
    final body = jsonEncode({
      'giveaway_type_id': giveawayTypeId,
      'product_id': productId,
    });

    final response = await authClient.request(
      method: 'POST',
      path: 'giveaway/claim-product-giveaway/',
      body: body,
    );

    final decoded = jsonDecode(response.body);
    final data = decoded is Map<String, dynamic>
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as Map<String, dynamic>? ??
              ['data'];

    if (data is Map<String, dynamic>) {
      return ProductGiveawayModel.fromJson(data);
    }

    return ProductGiveawayModel.fromJson(decoded);
  }

  @override
  Future<ProductClaimAddressModel> addProductDeliveryAddress({
    required String productId,
    required String fullName,
    required String phoneNumber,
    required String address,
  }) async {
    final body = jsonEncode({
      'product_id': productId,
      'full_name': fullName,
      'address': address,
      'phone_number': phoneNumber,
    });

    final response = await authClient.request(
      method: 'POST',
      path: 'giveaway/claim-product-giveaway/address/',
      body: body,
    );

    final decoded = jsonDecode(response.body);
    final data = decoded is Map<String, dynamic>
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as Map<String, dynamic>? ??
              ['data'];

    if (data is Map<String, dynamic>) {
      return ProductClaimAddressModel.fromJson(data);
    }

    return ProductClaimAddressModel.fromJson(decoded);
  }

  @override
  Future<List<DataGiveawayItem>> getDataGiveaways() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'giveaway/data-plans/',
    );

    final decoded = jsonDecode(response.body);

    final productsJson = decoded is List
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as List<dynamic>? ?? [];

    return productsJson
        .map((e) => DataGiveawayItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<DataGiveawayItem> claimDataGiveaway({
    required String dataId,
    required String giveawayTypeId,
    required String phone,
  }) async {
    final response = await authClient.request(
      method: 'POST',
      path: 'giveaway/claim-data-giveaway/',
      body: {
        'data_id': dataId,
        'giveaway_type_id': giveawayTypeId,
        'phone': phone,
      },
    );

    final decoded = jsonDecode(response.body);
    final data = decoded is Map<String, dynamic>
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as Map<String, dynamic>? ??
              ['data'];

    if (data is Map<String, dynamic>) {
      return DataGiveawayItem.fromJson(data);
    }

    return DataGiveawayItem.fromJson(decoded);
  }

  @override
  Future<UserCashAccountDetailModel> addCashAccountDetails({
    required String cashId,
    required String accountName,
    required String accountNumber,
    required String bankName,
    String? bankCode,
    String? phoneNumber,
  }) async {
    final body = jsonEncode({
      'cash_id': cashId,
      'account_name': accountName,
      'account_number': accountNumber,
      'bank_name': bankName,
      if (bankCode != null) 'bank_code': bankCode,
      if (phoneNumber != null) 'phone_number': phoneNumber,
    });

    final response = await authClient.request(
      method: 'POST',
      path: 'giveaway/claim-cash-giveaway/account-details/',
      body: body,
    );

    final decoded = jsonDecode(response.body);
    final data = decoded is Map<String, dynamic>
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as Map<String, dynamic>? ??
              ['data'];

    if (data is Map<String, dynamic>) {
      return UserCashAccountDetailModel.fromJson(data);
    }

    return UserCashAccountDetailModel.fromJson(decoded);
  }

  @override
  Future<CashGiveawayItem> claimCashGiveaway({
    required String cashId,
    required String giveawayTypeId,
  }) async {
    final body = jsonEncode({
      'cash_id': cashId,
      'giveaway_type_id': giveawayTypeId,
    });

    final response = await authClient.request(
      method: 'POST',
      path: 'giveaway/claim-cash-giveaway/',
      body: body,
    );

    final decoded = jsonDecode(response.body);
    final data = decoded is Map<String, dynamic>
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as Map<String, dynamic>? ??
              ['data'];

    if (data is Map<String, dynamic>) {
      return CashGiveawayItem.fromJson(data);
    }

    return CashGiveawayItem.fromJson(decoded);
  }

  @override
  Future<List<CashGiveawayItem>> getCashGiveaways() async {
    final response = await authClient.request(
      method: 'GET',
      path: 'giveaway/cash-list/',
    );

    final decoded = jsonDecode(response.body);

    final cashJson = decoded is List
        ? decoded
        : (decoded as Map<String, dynamic>)['data'] as List<dynamic>? ?? [];

    return cashJson
        .map((e) => CashGiveawayItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
