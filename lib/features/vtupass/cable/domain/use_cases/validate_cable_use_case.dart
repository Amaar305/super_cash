import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../../cable.dart';

class ValidateCableUsecase implements UseCase<Map, ValidateCableParam> {
  final CableRepository repository;

  ValidateCableUsecase({required this.repository});
  @override
  Future<Either<Failure, Map>> call(ValidateCableParam param) async {
    return await repository.validateCable(
      provider: param.provider,
      smartcardNumber: param.smartcardNumber,
    );
  }
}

class ValidateCableParam {
  final String provider;
  final String smartcardNumber;

  ValidateCableParam({required this.provider, required this.smartcardNumber});
}
