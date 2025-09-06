import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';

import '../../../../core/error/exception.dart';

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

      logD(jsonDecode(response.body));

      return AppUser.fromJson(response.body);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
