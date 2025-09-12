import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';
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
      final body = {'emailOrUsername': username, 'password': password};
      final response = await authClient.request(
        method: 'POST',
        path: 'auth/login/',
        body: body,
        withToken: false,
      );
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        logD(decoded);
        return TokenModel.fromJson(decoded);
      }

      throw ServerException('Unexpected response format.');
    } on RefreshTokenException catch (e) {
      // Bubble up so the app can force re-login if needed
      throw ServerException(e.message);
    } on ApiException catch (e) {
      // Non-2xx with server-provided message already extracted by AuthClient
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid JSON from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  @override
  Future<AppUser> fetchUserDetails() async {
    try {
      final res = await authClient.request(
        method: 'GET',
        path: '/auth/user-details/',
      );

      final decoded = jsonDecode(res.body);
      if (decoded is Map<String, dynamic>) {
        return AppUser.fromMap(decoded);
      }
      throw ServerException('Unexpected response format.');
    } on RefreshTokenException catch (e) {
      // Bubble up so the app can force re-login if needed
      throw ServerException(e.message);
    } on ApiException catch (e) {
      // Non-2xx with server-provided message already extracted by AuthClient
      throw ServerException(e.message);
    } on NetworkException catch (e) {
      throw ServerException(e.message);
    } on FormatException {
      throw ServerException('Invalid JSON from server.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
