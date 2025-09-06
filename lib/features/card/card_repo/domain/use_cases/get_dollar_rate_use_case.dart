import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/card/card_repo/card_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class GetDollarRateUseCase implements UseCase<DollarRate, NoParam> {
  final CardRepositories cardRepositories;

  GetDollarRateUseCase({required this.cardRepositories});

  @override
  Future<Either<Failure, DollarRate>> call(NoParam param) async {
    return await cardRepositories.getDollarRate();
  }
}
