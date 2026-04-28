import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GetCashGiveawaysUseCase
    implements UseCase<List<CashGiveawayItem>, NoParam> {
  final GiveawayRepository giveawayRepository;

  const GetCashGiveawaysUseCase({required this.giveawayRepository});
  @override
  Future<Either<Failure, List<CashGiveawayItem>>> call(NoParam param) async {
    return await giveawayRepository.getCashGiveaways();
  }
}
