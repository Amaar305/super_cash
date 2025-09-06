import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:fpdart/fpdart.dart';

class ValidateElectricityPlanUseCase
    implements UseCase<Map, ValidateElectricityPlanParams> {
  final ElectricityRepository electricityRepository;

  ValidateElectricityPlanUseCase({required this.electricityRepository});

  @override
  Future<Either<Failure, Map>> call(ValidateElectricityPlanParams param) async {
    return await electricityRepository.validatePlan(
      billersCode: param.billersCode,
      serviceID: param.serviceID,
      type: param.type,
    );
  }
}

class ValidateElectricityPlanParams {
  final String billersCode;
  final String serviceID;
  final String type;

  const ValidateElectricityPlanParams({
    required this.billersCode,
    required this.serviceID,
    required this.type,
  });
}
