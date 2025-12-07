import 'dart:convert';

import 'package:app_client/app_client.dart';

abstract interface class CableRemoteDataSource {
  Future<Map> fetchCableResponse({required String provider});
  Future<Map> validateCable({
    required String provider,
    required String smartcardNumber,
  });
  Future<Map> buyCable({
    required String provider,
    required String variationCode,
    required String smartcardNumber,
    required String phone,
  });
}

class CableRemoteDataSourceImpl implements CableRemoteDataSource {
  final AuthClient authClient;

  const CableRemoteDataSourceImpl({required this.authClient});
  @override
  Future<Map> buyCable({
    required String provider,
    required String variationCode,
    required String smartcardNumber,
    required String phone,
  }) async {
    final body = jsonEncode({
      "provider": provider.toLowerCase(),
      "variation_code": variationCode,
      "phone": phone,
      "smartcard_number": smartcardNumber,
    });
    final response = await authClient.request(
      method: 'POST',
      path: 'vtu/cable-purchase/',
      body: body,
    );

    // flutter: {phone: [Ensure this field has no more than 11 characters.]}

    Map res = jsonDecode(response.body);

    return res;
  }

  @override
  Future<Map> fetchCableResponse({required String provider}) async {
    final body = jsonEncode({});
    final response = await authClient.request(
      method: 'GET',
      path: 'vtu/get-cable-plans/$provider',
      body: body,
    );

    Map res = jsonDecode(response.body);
    return res;
  }

  @override
  Future<Map> validateCable({
    required String provider,
    required String smartcardNumber,
  }) async {
    final body = jsonEncode({
      "provider": provider.toLowerCase(),
      "smartcard_number": smartcardNumber,
    });

    final response = await authClient.request(
      method: 'POST',
      path: 'vtu/cable-verification/',
      body: body,
    );

    // flutter: {phone: [Ensure this field has no more than 11 characters.]}

    Map res = jsonDecode(response.body);

    // logD(res);

    return res;
  }
}
