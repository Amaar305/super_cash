import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../domain.dart';

class FetchDataPlanUseCase
    implements UseCase<DataPlanResponse, FetchDataPlanParam> {
  final DataRepository repository;

  FetchDataPlanUseCase({required this.repository});
  @override
  Future<Either<Failure, DataPlanResponse>> call(
    FetchDataPlanParam param,
  ) async {
    return await repository.fetchPlans(network: param.network);
  }
}

class FetchDataPlanParam {
  final String network;

  FetchDataPlanParam({required this.network});
}
