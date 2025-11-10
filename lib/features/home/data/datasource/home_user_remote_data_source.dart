import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:token_repository/token_repository.dart';

abstract class HomeUserRemoteDataSource {
  Future<AppUser> fetchUserDetails();
}

class HomeUserRemoteDataSourceImpl implements HomeUserRemoteDataSource {
  final AuthClient authClient;

  HomeUserRemoteDataSourceImpl({required this.authClient});

  @override
  Future<AppUser> fetchUserDetails() async {
    try {
      final body = jsonEncode({});
      final response = await authClient.request(
        method: 'GET',
        path: 'auth/user-details/',
        body: body,
      );

      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return AppUser.fromMap(decoded);
      }
      throw ServerException('Unexpected response format.');
    } on RefreshTokenException catch (e) {
      throw ServerException(e.message);
    } on ApiException catch (e) {
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
