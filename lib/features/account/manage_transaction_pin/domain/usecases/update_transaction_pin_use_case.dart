import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';

import '../repository/change_transaction_pin_repository.dart';

class UpdateTransactionPinUseCase
    implements UseCase<String, UpdateTransactionPinParams> {
  final ChangeTransactionPinRepository changeTransactionPinRepository;

  UpdateTransactionPinUseCase({required this.changeTransactionPinRepository});

  @override
  Future<Either<Failure, String>> call(UpdateTransactionPinParams param) async {
    return await changeTransactionPinRepository.changeTransactionPin(
      currentPin: param.currentPin,
      newPin: param.newPin,
      cofirmPin: param.confirmPin,
    );
  }
}

class UpdateTransactionPinParams {
  final String currentPin;
  final String newPin;
  final String confirmPin;

  UpdateTransactionPinParams({
    required this.currentPin,
    required this.newPin,
    required this.confirmPin,
  });
}
