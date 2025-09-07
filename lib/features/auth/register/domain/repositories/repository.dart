import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../domain.dart';

abstract interface class RegisterRepository {
  Future<Either<Failure, AuthUser>> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String? referral,
  });
}
