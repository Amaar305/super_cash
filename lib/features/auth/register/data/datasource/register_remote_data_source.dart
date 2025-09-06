import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';

import '../data.dart';

abstract interface class RegisterRemoteDataSource {
  Future<AuthUserModel> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
  });
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final AuthClient apiClient;

  RegisterRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<AuthUserModel> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final body = jsonEncode({
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        'password2': confirmPassword,
        'phone_number': phone,
      });
      final res = await apiClient.request(
        method: 'POST',
        path: 'auth/register/',
        body: body,
      );

      logD(res.body);

      if (res.statusCode != 201) {
        // logD(res.body);
        // try {
        final Map<String, dynamic> response = jsonDecode(res.body);
        if (response.containsKey('phone_number') &&
            response['phone_number'].runtimeType == List) {
          throw ServerException(response['phone_number'][0]);
        }
        if (response.containsKey('email') &&
            response['email'].runtimeType == List) {
          throw ServerException(response['email'][0]);
        }
        if (response.containsKey('password') &&
            response['password'].runtimeType == List) {
          throw ServerException(response['password'][0]);
        }
        if (response.containsKey('password2') &&
            response['password2'].runtimeType == List) {
          throw ServerException(response['password2'][0]);
        }
        if (response.containsKey('non_field_errors') &&
            response['non_field_errors'].runtimeType == List) {
          throw ServerException(response['non_field_errors'][0]);
        }
        if (response.containsKey('referral_code') &&
            response['referral_code'].runtimeType == List) {
          throw ServerException(response['referral_code'][0]);
        }
        final message = extractErrorMessage(response);

        throw ServerException(message);
        // } catch (e) {
        //   throw ServerException('Something went wrong. Try again later.');
        // }
      }

      // if (res.statusCode != 201) {
      //   Map<String, dynamic> response = jsonDecode(res.body);
      //   if (response.containsKey('phone_number') &&
      //       response['phone_number'].runtimeType == List) {
      //     throw ServerException(response['phone_number'][0]);
      //   }
      //   if (response.containsKey('email') &&
      //       response['email'].runtimeType == List) {
      //     throw ServerException(response['email'][0]);
      //   }
      //   if (response.containsKey('password') &&
      //       response['password'].runtimeType == List) {
      //     throw ServerException(response['password'][0]);
      //   }
      //   if (response.containsKey('password2') &&
      //       response['password2'].runtimeType == List) {
      //     throw ServerException(response['password2'][0]);
      //   }
      //   if (response.containsKey('non_field_errors') &&
      //       response['non_field_errors'].runtimeType == List) {
      //     throw ServerException(response['non_field_errors'][0]);
      //   }
      //   if (response.containsKey('referral_code') &&
      //       response['referral_code'].runtimeType == List) {
      //     throw ServerException(response['referral_code'][0]);
      //   }
      //   final message = extractErrorMessage(response);

      //   throw ServerException(message);
      // }

      // logD(jsonDecode(res.body));
      final Map<String, dynamic> response = jsonDecode(res.body);
      return AuthUserModel.fromMap(response['user'] as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
