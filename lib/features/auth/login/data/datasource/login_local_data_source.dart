import 'package:shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<void> cacheTokens(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();

  Future<void> persistUser(AppUser user);
  AppUser? getUser();
  Future<void> clearUser();
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheTokens(String accessToken, String refreshToken) async {
    await sharedPreferences.setString('accessToken', accessToken);
    await sharedPreferences.setString('refreshToken', refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString('accessToken');
  }

  @override
  Future<String?> getRefreshToken() async {
    return sharedPreferences.getString('refreshToken');
  }

  @override
  Future<void> clearTokens() async {
    await sharedPreferences.remove('accessToken');
    await sharedPreferences.remove('refreshToken');
  }

  @override
  Future<void> persistUser(AppUser user) async {
    await sharedPreferences.setString('user_data', user.toJson());
  }

  @override
  AppUser? getUser()  {
    final userData = sharedPreferences.getString('user_data');
    return userData != null ? AppUser.fromJson(userData) : null;
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferences.remove('user_data');
  }
}
