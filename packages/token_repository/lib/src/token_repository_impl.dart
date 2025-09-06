import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_repository/token_repository.dart';

///A concrede implementation of [TokenRepository]
class TokenRepositoryImpl implements TokenRepository {
  /// {@macro token_repository}

  const TokenRepositoryImpl(this.sharedPreferences);

  ///
  final SharedPreferences sharedPreferences;

  @override
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString('accessToken');
  }

  @override
  Future<String?> getRefreshToken() async {
    return sharedPreferences.getString('refreshToken');
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await sharedPreferences.setString('accessToken', token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await sharedPreferences.setString('refreshToken', token);
  }

  @override
  Future<void> clearTokens() async {
    await sharedPreferences.remove('accessToken');
    await sharedPreferences.remove('refreshToken');
    await sharedPreferences.remove('enableBiometric');
  }

  @override
  Future<bool> hasToken() async {
    final refress = sharedPreferences.getString('refreshToken');
    final access = sharedPreferences.getString('accessToken');

    if (refress == null) {
      return false;
    } else if (access == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> setBiometricEnabled({required bool enable}) async {
    await sharedPreferences.setBool('enableBiometric', enable);
  }

  @override
  bool? getBiometric() {
    return sharedPreferences.getBool('enableBiometric');
  }
}
