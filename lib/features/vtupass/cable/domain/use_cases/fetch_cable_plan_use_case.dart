import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/usecase/use_case.dart';
import '../../cable.dart';

class FetchCablePlanUseCase implements UseCase<Map, CableParam> {
  final CableRepository repository;

  FetchCablePlanUseCase({required this.repository});

  @override
  Future<Either<Failure, Map>> call(CableParam param) async {
    return await repository.fetchCableResponse(provider: param.provider);
  }
}

class CableParam {
  final String provider;

  CableParam({required this.provider});
}
