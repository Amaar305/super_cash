import 'dart:convert';
import 'dart:io';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/features/upgrade_tier/upgrade_tier.dart';

import '../../../../core/error/errorr_message.dart';

abstract interface class UpgradeTierRemoteDataSource {
  Future<Map<String, dynamic>> upgradeAccount({
    required UpgradeAccountProps props,
  });

  Future<bool> checkUpgradeStatus();

  Future<String?> uploadSelfieImage({required File file});
  Future<void> deleteSelfieImage(String imageUrl);
}

class UpgradeTierRemoteDataSourceImpl implements UpgradeTierRemoteDataSource {
  final AuthClient apiClient;

  UpgradeTierRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<Map<String, dynamic>> upgradeAccount({
    required UpgradeAccountProps props,
  }) async {
    
      final response = await apiClient.request(
        method: 'POST',
        path: 'card/register-cardholder/',
        body: jsonEncode(props.toMap()),
      );

      final Map<String, dynamic> res = jsonDecode(response.body);

      if (response.statusCode != 201) {
        // Delete uploaded selfie image if request fails
        deleteSelfieImage(props.selfie!);

        final message = extractErrorMessage(res);
        throw ServerException(message);
      }

      return res;
    
  }

  @override
  Future<String?> uploadSelfieImage({required File file}) async {
    
      final response = await apiClient.multipart(
        path: 'card/uploads/selfie/',
        file: file,
        fileField: 'file',
      );
      
      final data = jsonDecode(response.body);
      return data['url'] as String?;
   
  }

  @override
  Future<void> deleteSelfieImage(String imageUrl) async {
  
      final response = await apiClient.request(
        method: 'DELETE',
        path: 'card/uploads/selfie/delete/',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': imageUrl}),
      );
      if (response.statusCode != 200) {
        throw ServerException('Failed to delete image.');
      }
    
  }

  @override
  Future<bool> checkUpgradeStatus() async {
    
      final response = await apiClient.request(
        method: 'GET',
        path: 'card/cardholder-confirm/',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({}),
      );

      Map<String, dynamic> res = jsonDecode(response.body);

      if (!res.containsKey('cardholder_exists')) {
        throw ServerException('Something went wrong. Try again later.');
      }

      return res['cardholder_exists'];
    
  }
}
