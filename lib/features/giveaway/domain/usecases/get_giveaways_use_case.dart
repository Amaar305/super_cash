import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GetGiveawaysUseCase implements UseCase<List<Giveaway>, NoParam> {
  final GiveawayRepository _giveawayRepository;

  GetGiveawaysUseCase(this._giveawayRepository);

  @override
  Future<Either<Failure, List<Giveaway>>> call(NoParam params) async {
    return await _giveawayRepository.getGiveaways();
  }
}
