import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GetGiveawayWinnersUseCase
    implements UseCase<List<GiveawayWinner>, NoParam> {
  final GiveawayRepository giveawayRepository;

  const GetGiveawayWinnersUseCase({required this.giveawayRepository});

  @override
  Future<Either<Failure, List<GiveawayWinner>>> call(NoParam param) async {
    return giveawayRepository.getWinners();
  }
}
