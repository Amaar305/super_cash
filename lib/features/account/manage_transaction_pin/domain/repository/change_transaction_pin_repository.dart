import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';

abstract interface class ChangeTransactionPinRepository {
  Future<Either<Failure, String>> changeTransactionPin({
    required String currentPin,
    required String newPin,
    required String cofirmPin,
  });

  Future<Either<Failure, Map>> requestOtpWithEmail(String email);

  Future<Either<Failure, Map>> resetTransactionPin({
    required String password,
    required String pin,
    required String confirmPin,
  });
}
