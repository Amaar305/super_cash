import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';
import 'package:fpdart/fpdart.dart';

class VerifyTransactionPinUseCase
    implements UseCase<ConfirmPin, VerifyTransactionParam> {
  final ConfirmTransactionPinRepositories confirmTransationPinRepositories;

  VerifyTransactionPinUseCase({required this.confirmTransationPinRepositories});

  @override
  Future<Either<Failure, ConfirmPin>> call(VerifyTransactionParam param) async {
    return await confirmTransationPinRepositories.veriFyTransactionPin(
      param.pin,
    );
  }
}

class VerifyTransactionParam {
  final String pin;

  VerifyTransactionParam({required this.pin});
}
