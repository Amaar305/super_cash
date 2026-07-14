import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';

abstract interface class FetchVirtualCardRemoteDataSource {
  Future<List<Card>> fetchAllVirtualCards();
}

class FetchVirtualCardRemoteDataSourceImpl
    implements FetchVirtualCardRemoteDataSource {
  final AuthClient apiClient;

  const FetchVirtualCardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<Card>> fetchAllVirtualCards() async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'virtual_cards/cards/',
    );

    Map<String, dynamic> res = jsonDecode(response.body);

    final data = res['data'] as List<dynamic>?;
    if (data == null) return [];
    return List<dynamic>.from(
      data,
    ).map((e) => Card.fromJson(e as Map<String, dynamic>)).toList();
  }
}
