import 'package:shared/shared.dart';
import 'package:super_cash/core/error/failure.dart';

import 'package:fpdart/fpdart.dart';
import 'package:super_cash/features/auth/login/login.dart';
import 'package:token_repository/token_repository.dart';

import '../../../../../core/error/exception.dart';
import '../../register.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource registerRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;

  final TokenRepository tokenRepository;

  const RegisterRepositoryImpl({
    required this.registerRemoteDataSource,
    required this.loginLocalDataSource,
    required this.tokenRepository,
  });

  @override
  Future<Either<Failure, AppUser>> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String? referral,
  }) async {
    try {
      final user = await registerRemoteDataSource.register(
        email: email,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        password: password,
        confirmPassword: confirmPassword,
        referral: referral,
      );
      tokenRepository
        ..saveAccessToken(user.tokens!.access)
        ..saveRefreshToken(user.tokens!.refresh);

      await loginLocalDataSource.persistUser(user);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
