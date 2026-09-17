import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/smile/domain/domain.dart';

class FetchSmilePlansUseCase implements UseCase<SmilePlanResponse, NoParam> {
  final SmileRepository repository;

  const FetchSmilePlansUseCase({required this.repository});

  @override
  Future<Either<Failure, SmilePlanResponse>> call(NoParam param) {
    return repository.fetchPlans();
  }
}
