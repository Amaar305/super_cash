import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';

import '../repository/change_transaction_pin_repository.dart';

class ResetTransactionPinUseCase
    implements UseCase<Map, ResetTransactionPinParam> {
  final ChangeTransactionPinRepository changeTransactionPinRepository;

  ResetTransactionPinUseCase({required this.changeTransactionPinRepository});

  @override
  Future<Either<Failure, Map>> call(ResetTransactionPinParam param) async {
    return await changeTransactionPinRepository.resetTransactionPin(
      email: param.email,
      otp: param.otp,
      pin: param.pin,
      confirmPin: param.confirmPin,
    );
  }
}

class ResetTransactionPinParam {
  final String email;
  final String otp;
  final String pin;
  final String confirmPin;

  const ResetTransactionPinParam({
    required this.email,
    required this.otp,
    required this.pin,
    required this.confirmPin,
  });
}
