/// {@template token_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract interface class TokenRepository {
  /// {@macro token_repository}
  Future<String?> getAccessToken();

  /// {@macro token_repository}

  Future<String?> getRefreshToken();

  /// {@macro token_repository}

  Future<void> saveAccessToken(String token);

  /// {@macro token_repository}

  Future<void> saveRefreshToken(String token);

  /// {@macro token_repository}

  Future<void> clearTokens();

  /// {@macro token_repository}

  Future<bool> hasToken();

  /// {@macro token_repository}
  Future<void> setBiometricEnabled({required bool enable});

  /// {@macro token_repository}

  bool? getBiometric();
}
