import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class FetchVirtualCardRemoteDataSource {
  Future<List<Card>> fetchAllVirtualCards();
}

class FetchVirtualCardRemoteDataSourceImpl
    implements FetchVirtualCardRemoteDataSource {
  final AuthClient apiClient;

  FetchVirtualCardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<Card>> fetchAllVirtualCards() async {
    try {
      final response = await apiClient.request(
        method: 'GET',
        path: 'card/cards/',
        body: jsonEncode({}),
      );

      Map<String, dynamic> res = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);
        throw ServerException(message);
      }
      final data = res['results'];
      return List<dynamic>.from(
        data! as List<dynamic>,
      ).map((e) => Card.fromJson(e as Map<String, dynamic>)).toList();
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
