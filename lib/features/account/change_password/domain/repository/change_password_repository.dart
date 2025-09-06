import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ChangePasswordRepository {
  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
