import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';

import '../repository/change_transaction_pin_repository.dart';

class RequestTransactionPinOtpUseCase
    implements UseCase<Map, RequestTransactionPinOtpParam> {
  final ChangeTransactionPinRepository changeTransactionPinRepository;

  RequestTransactionPinOtpUseCase({
    required this.changeTransactionPinRepository,
  });

  @override
  Future<Either<Failure, Map>> call(RequestTransactionPinOtpParam param) async {
    return await changeTransactionPinRepository.requestOtpWithEmail(
      param.email,
    );
  }
}

class RequestTransactionPinOtpParam {
  final String email;

  const RequestTransactionPinOtpParam({required this.email});
}
