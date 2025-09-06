import 'dart:convert';
import 'dart:io';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import '../models/token_model.dart';

abstract class LoginRemoteDataSource {
  Future<TokenModel> login({
    required String username,
    required String password,
  });
  Future<AppUser> fetchUserDetails();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final AuthClient authClient;

  LoginRemoteDataSourceImpl(this.authClient);

  @override
  Future<TokenModel> login({
    required String username,
    required String password,
  }) async {
    try {
      // final headers = {
      //   'Content-Type': 'application/json',
      // };
      final body = jsonEncode({
        'emailOrUsername': username,
        'password': password,
      });
      final response = await authClient.request(
        method: 'POST',
        path: 'auth/login/',
        body: body,
        // headers: headers,
        withToken: false,
      );
      if (response.statusCode != 200) {
        var response2 = jsonDecode(response.body);

        if (response2.containsKey('password')) {
          throw ServerException(
            (response2['password'][0] as String).replaceAll('This', 'Password'),
          );
        }
        if (response2.containsKey('emailOrUsername')) {
          throw ServerException(
            (response2['emailOrUsername'][0] as String).replaceAll(
              'This',
              'Email or Phone',
            ),
          );
        }
        if (response2.containsKey('detail')) {
          throw ServerException(response2['detail']);
        }
        if (response2.containsKey('non_field_errors') &&
            response2['non_field_errors'].runtimeType == List) {
          throw ServerException(response2['non_field_errors'][0]);
        }
      }

      var response2 = jsonDecode(response.body);
      return TokenModel.fromJson(response2);
    } on HttpException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AppUser> fetchUserDetails() async {
    try {
      final body = jsonEncode({});
      final response = await authClient.request(
        method: 'GET',
        path: 'auth/user-details/',
        body: body,
      );

      logE(response.body);

      if (response.statusCode != 200) {
        throw ServerException('Failed to fetch user details');
      }

      return AppUser.fromJson(response.body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
