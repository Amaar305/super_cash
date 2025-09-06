import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../domain.dart';

class BuyDataPlanUseCase
    implements UseCase<TransactionResponse, BuyDataPlanParam> {
  final DataRepository repository;

  BuyDataPlanUseCase({required this.repository});
  @override
  Future<Either<Failure, TransactionResponse>> call(
    BuyDataPlanParam param,
  ) async {
    return await repository.buyDataPlan(
      network: param.network,
      planId: param.planId,
      phoneNumber: param.phoneNumber,
    );
  }
}

class BuyDataPlanParam {
  final String network;
  final String planId;
  final String phoneNumber;

  BuyDataPlanParam({
    required this.network,
    required this.planId,
    required this.phoneNumber,
  });
}
