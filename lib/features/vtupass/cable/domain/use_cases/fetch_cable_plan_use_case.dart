import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';



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

 const CableParam({required this.provider});
}
