import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

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

  CableRemoteDataSourceImpl({required this.authClient});
  @override
  Future<Map> buyCable({
    required String provider,
    required String variationCode,
    required String smartcardNumber,
    required String phone,
  }) async {
    try {
      final body = jsonEncode({
        "provider": provider,
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
      if (res.containsKey('status') && res['status'] == 'fail') {
        throw ServerException(res['message']);
      } else if (res.containsKey('status') &&
          res['status'].runtimeType == List &&
          res['status'][0] == 'fail') {
        throw ServerException(res['message'][0]);
      }
      if (res.containsKey('non_field_errors') &&
          res['non_field_errors'].runtimeType == String) {
        throw ServerException(res['non_field_errors']);
      }
      if (res.containsKey('non_field_errors') &&
          res['non_field_errors'].runtimeType == List) {
        throw ServerException(res['non_field_errors'][0]);
      }

      if (res.containsKey('detail')) {
        throw ServerException(res['detail']);
      }

      return res;
    } on RefreshTokenException catch (e) {
      throw RefreshTokenException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map> fetchCableResponse({required String provider}) async {
    try {
      final body = jsonEncode({});
      final response = await authClient.request(
        method: 'GET',
        path: 'vtu/get-cable-plans/$provider',
        body: body,
      );

      // flutter: {phone: [Ensure this field has no more than 11 characters.]}

      Map res = jsonDecode(response.body);
      if (res.containsKey('non_field_errors') &&
          res['non_field_errors'].runtimeType == String) {
        throw ServerException(res['non_field_errors']);
      }
      if (res.containsKey('non_field_errors') &&
          res['non_field_errors'].runtimeType == List) {
        throw ServerException(res['non_field_errors'][0]);
      }

      if (res.containsKey('detail')) {
        throw ServerException(res['detail']);
      }

      if (res.containsKey('status') && res['status'] == 'fail') {
        throw ServerException(res['message']);
      } else if (res.containsKey('status') &&
          res['status'].runtimeType == List &&
          res['status'][0] == 'fail') {
        throw ServerException(res['message'][0]);
      }

      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map> validateCable({
    required String provider,
    required String smartcardNumber,
  }) async {
    try {
      final body = jsonEncode({
        "provider": provider,
        "smartcard_number": smartcardNumber,
      });
      final response = await authClient.request(
        method: 'POST',
        path: 'vtu/cable-verification/',
        body: body,
      );

      // flutter: {phone: [Ensure this field has no more than 11 characters.]}

      Map res = jsonDecode(response.body);

      if (res.containsKey('phone') && res['phone'].runtimeType == List) {
        throw ServerException('Phone number code is required');
      }
      if (res.containsKey('variation_code') &&
          res['variation_code'].runtimeType == List) {
        throw ServerException('Variation code is required');
      }
      if (res.containsKey('non_field_errors') &&
          res['non_field_errors'].runtimeType == String) {
        throw ServerException(res['non_field_errors']);
      }
      if (res.containsKey('non_field_errors') &&
          res['non_field_errors'].runtimeType == List) {
        throw ServerException(res['non_field_errors'][0]);
      }

      if (res.containsKey('detail')) {
        throw ServerException(res['detail']);
      }

      if (res.containsKey('status') && res['status'] == 'fail') {
        throw ServerException(res['message']);
      } else if (res.containsKey('status') &&
          res['status'].runtimeType == List &&
          res['status'][0] == 'fail') {
        throw ServerException(res['message'][0]);
      }

      return res;
    } on RefreshTokenException catch (e) {
      throw RefreshTokenException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
