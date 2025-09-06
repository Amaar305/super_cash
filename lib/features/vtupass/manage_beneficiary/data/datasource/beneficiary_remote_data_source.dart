import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

import '../../manage_beneficiary.dart';

abstract interface class BeneficiaryRemoteDataSource {
  Future<BeneficiaryResponse> fetchBeneficiary(int page);
  Future<Beneficiary> saveBeneficiary({
    required String name,
    required String phone,
    required String network,
  });
  Future<Beneficiary> updateBeneficiary({
    required String id,
    String? name,
    String? phone,
    String? network,
  });
  Future<void> deleteBeneficiary({required String id});
}

class BeneficiaryRemoteDataSourceImpl implements BeneficiaryRemoteDataSource {
  final AuthClient apiClient;
  const BeneficiaryRemoteDataSourceImpl(this.apiClient);

  @override
  Future<void> deleteBeneficiary({required String id}) async {
    try {
      final response = await apiClient.request(
        method: 'DELETE',
        path: 'vtu/beneficiary/$id/',
        body: jsonEncode({}),
      );
      if (response.statusCode != 204) {
        throw ServerException('Something went wrong. Try again later');
      }
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<BeneficiaryResponse> fetchBeneficiary(int page) async {
    try {
      final response = await apiClient.request(
        method: 'GET',
        path: 'vtu/beneficiaries/?page=$page',
        body: jsonEncode({}),
      );

      if (response.statusCode != 200) {
        throw ServerException('Something went wrong. Try again later');
      }
      Map<String, dynamic> res = jsonDecode(response.body);
      return BeneficiaryResponse.fromMap(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<Beneficiary> saveBeneficiary({
    required String name,
    required String phone,
    required String network,
  }) async {
    try {
      final response = await apiClient.request(
        method: 'POST',
        path: 'vtu/beneficiaries/',
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'network': network.toLowerCase(),
        }),
      );
      Map<String, dynamic> res = jsonDecode(response.body);
      if (response.statusCode != 201) {
        final message = extractErrorMessage(res);
        throw ServerException(message);
      }
      return Beneficiary.fromMap(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<Beneficiary> updateBeneficiary({
    required String id,
    String? name,
    String? phone,
    String? network,
  }) async {
    try {
      final response = await apiClient.request(
        method: 'PATCH',
        path: 'vtu/beneficiary/$id/',
        body: jsonEncode({
          if (name != null) 'name': name,
          if (phone != null) 'phone': phone,
          if (network != null) 'network': network.toLowerCase(),
        }),
      );
      if (response.statusCode != 200) {
        throw ServerException('Something went wrong. Try again later');
      }
      Map<String, dynamic> res = jsonDecode(response.body);
      return Beneficiary.fromMap(res);
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
