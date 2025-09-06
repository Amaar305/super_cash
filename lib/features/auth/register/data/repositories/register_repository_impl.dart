import 'package:super_cash/core/error/failure.dart';

import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/exception.dart';
import '../../register.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource registerRemoteDataSource;

  RegisterRepositoryImpl({required this.registerRemoteDataSource});
  @override
  Future<Either<Failure, AuthUser>> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final data = await registerRemoteDataSource.register(
        email: email,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        password: password,
        confirmPassword: confirmPassword,
      );
      return right(data);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
