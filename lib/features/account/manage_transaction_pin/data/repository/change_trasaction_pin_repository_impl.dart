import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/api_error_handle.dart';

import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/account/manage_transaction_pin/data/data.dart';
import 'package:super_cash/features/account/manage_transaction_pin/domain/domain.dart';

class ChangeTransactionPinRepositoryImpl
    implements ChangeTransactionPinRepository {
  final ChangeTransactionPinRemoteDataSource
  changeTransactionPinRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  const ChangeTransactionPinRepositoryImpl({
    required this.changeTransactionPinRemoteDataSource,
    required this.apiErrorHandler,
  });
  @override
  Future<Either<Failure, String>> changeTransactionPin({
    required String currentPin,
    required String newPin,
    required String cofirmPin,
  }) async {
    try {
      final result = await changeTransactionPinRemoteDataSource
          .changeTransactionPin(
            currentPin: currentPin,
            newPin: newPin,
            cofirmPin: cofirmPin,
          );
      return right(result);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, Map>> requestOtpWithEmail(String email) async {
    try {
      final result = await changeTransactionPinRemoteDataSource
          .requestOtpWithEmail(email);

      return right(result);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, Map>> resetTransactionPin({
    required String password,
    required String pin,
    required String confirmPin,
  }) async {
    try {
      final result = await changeTransactionPinRemoteDataSource
          .resetTransactionPin(
            password: password,
            pin: pin,
            confirmPin: confirmPin,
          );

      return right(result);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
