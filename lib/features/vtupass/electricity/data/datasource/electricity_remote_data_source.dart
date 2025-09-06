import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

abstract class ElectricityRemoteDataSource {
  Future<ElectricityPlan> getPlans();
  Future<Map> validatePlan({
    required String billersCode,
    required String serviceID,
    required String type,
  });
  Future<TransactionResponse> buyPlan({
    required String billersCode,
    required String serviceID,
    required String type,
    required String amount,
    required String phone,
  });
}

class ElectricityRemoteDataSourceImpl implements ElectricityRemoteDataSource {
  final AuthClient authClient;

  ElectricityRemoteDataSourceImpl({required this.authClient});

  @override
  Future<TransactionResponse> buyPlan({
    required String billersCode,
    required String serviceID,
    required String type,
    required String amount,
    required String phone,
  }) async {
    try {
      final body = jsonEncode({
        "billersCode": billersCode,
        "serviceID": serviceID,
        "variation_code": type,
        "amount": amount,
        "phone": phone,
      });
      final response = await authClient.request(
        method: 'POST',
        path: 'vtu/electricity-purrchase/',
        body: body,
      );

      // flutter: {phone: [Ensure this field has no more than 11 characters.]}

      Map<String, dynamic> res = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);

        throw ServerException(message);
      }
      return TransactionResponse.fromJson(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ElectricityPlan> getPlans() async {
    try {
      final body = jsonEncode({});
      final response = await authClient.request(
        method: 'GET',
        path: 'vtu/get-electricity-plans/',
        body: body,
      );

      // flutter: {phone: [Ensure this field has no more than 11 characters.]}

      Map<String, dynamic> res = jsonDecode(response.body);
      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);

        throw ServerException(message);
      }

      return ElectricityPlan.fromJson(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map> validatePlan({
    required String billersCode,
    required String serviceID,
    required String type,
  }) async {
    try {
      final body = jsonEncode({
        "billersCode": billersCode,
        "serviceID": serviceID,
        "type": type,
      });
      final response = await authClient.request(
        method: 'POST',
        path: 'vtu/electricity-verification/',
        body: body,
      );

      Map<String, dynamic> res = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);

        throw ServerException(message);
      }

      return res;
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
