import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../domain.dart';

class CreatePinUseCase implements UseCase<Map, CreatePinParam> {
  final CreatePinRepository createPinRepository;

  CreatePinUseCase({required this.createPinRepository});
  @override
  Future<Either<Failure, Map>> call(CreatePinParam param) async {
    return await createPinRepository.createTransactionPin(param.pin);
  }
}

class CreatePinParam {
  final String pin;

  const CreatePinParam({required this.pin});
}
