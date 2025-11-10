import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/bonus/domain/domain.dart';

class FetchBankListUseCase implements UseCase<List<Bank>, NoParam> {
  final BonusRepository bonusRepository;

  FetchBankListUseCase({required this.bonusRepository});

  @override
  Future<Either<Failure, List<Bank>>> call(NoParam param) {
    return bonusRepository.getBankLists();
  }
}
