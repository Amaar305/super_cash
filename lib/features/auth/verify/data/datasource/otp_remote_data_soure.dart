import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';

abstract interface class OtpRemoteDataSoure {
  Future<Map> verifyOTP(String otp);
}

class OtpRemoteDataSoureImpl implements OtpRemoteDataSoure {
  final AuthClient apiClient;

  OtpRemoteDataSoureImpl({required this.apiClient});

  @override
  Future<Map> verifyOTP(String otp) async {
    try {
      final body = jsonEncode({'otp': otp});
      final response = await apiClient.request(
        method: 'POST',
        path: 'auth/verify-email/',
        body: body,
      );
      Map<String, dynamic> res = jsonDecode(response.body);

      if (res.containsKey('otp') && res['otp'].runtimeType == List) {
        throw ServerException(
          (res['otp'][0] as String).replaceAll('field', 'otp'),
        );
      }

      if (res.containsKey('status') && res['status'] == 'fail') {
        throw ServerException((res['message']));
      }
      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
