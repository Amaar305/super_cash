import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GetGiveawayHistoriesUseCase implements UseCase<List<GiveawayHistory>, NoParam> {
  final GiveawayRepository _giveawayRepository;

  const GetGiveawayHistoriesUseCase(this._giveawayRepository);

  @override
  Future<Either<Failure, List<GiveawayHistory>>> call(NoParam params) async {
    return await _giveawayRepository.getHistories();
  }
}

