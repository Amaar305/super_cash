import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../domain.dart';

class GetElectricityPlansUseCase implements UseCase<ElectricityPlan, NoParam> {
  final ElectricityRepository electricityRepository;

  GetElectricityPlansUseCase({required this.electricityRepository});

  @override
  Future<Either<Failure, ElectricityPlan>> call(NoParam param) async {
    return await electricityRepository.getPlans();
  }
}
