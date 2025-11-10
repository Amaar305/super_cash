import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/network/network_info.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

import '../../login.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginLocalDataSource loginLocalDataSource;
  final LoginRemoteDataSource loginRemoteDataSource;
  final TokenRepository tokenRepository;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.loginLocalDataSource,
    required this.loginRemoteDataSource,
    required this.tokenRepository,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AppUser>> login(
    String username,
    String password,
  ) async {
    if (!await networkInfo.isConnected) {
      return left(NetworkFailure("No internet connection."));
    }
    try {
      final user = await loginRemoteDataSource.login(
        username: username,
        password: password,
      );

      tokenRepository
        ..saveAccessToken(user.tokens!.access)
        ..saveRefreshToken(user.tokens!.refresh);

      await loginLocalDataSource.persistUser(user);

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await loginLocalDataSource.clearTokens();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AppUser>> fetchUserDetails() async {
    try {
      if (!await networkInfo.isConnected) {
        return left(NetworkFailure("No internet connection."));
      }
      final res = await loginRemoteDataSource.fetchUserDetails();
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on RefreshTokenException catch (_) {
      return left(
        RefreshTokenFailure("Session expired. Use email & password to login."),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> loginWithDeviceFingerprint() async {
    try {
      if (!await networkInfo.isConnected) {
        return left(NetworkFailure("No internet connection."));
      }

      final user = await loginRemoteDataSource.loginWithDeviceFingerprint();

      tokenRepository
        ..saveAccessToken(user.tokens!.access)
        ..saveRefreshToken(user.tokens!.refresh);

      await loginLocalDataSource.persistUser(user);

      return Right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
