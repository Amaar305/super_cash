import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';
import 'package:fpdart/fpdart.dart';

class ConfirmTransactionPinRepositoriesImpl
    implements ConfirmTransactionPinRepositories {
  final ConfirmTransactionPinRemoteDataSource
  confirmTransactionPinRemoteDataSource;

  final ApiErrorHandler apiErrorHandler;

  ConfirmTransactionPinRepositoriesImpl({
    required this.confirmTransactionPinRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, ConfirmPin>> veriFyTransactionPin(String pin) async {
    try {
      final response = await confirmTransactionPinRemoteDataSource
          .veriFyTransactionPin(pin);

      return right(response);
    } catch (e) {
      return left(apiErrorHandler.handleError(e));
    }
  }
}
