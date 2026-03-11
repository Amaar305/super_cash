import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GetAirtimeGiveawayPinsUseCase
    implements UseCase<List<AirtimeGiveawayPin>, NoParam> {
  final GiveawayRepository giveawayRepository;

  const GetAirtimeGiveawayPinsUseCase({required this.giveawayRepository});

  @override
  Future<Either<Failure, List<AirtimeGiveawayPin>>> call(NoParam param) async {
    return await giveawayRepository.getAirtimeGiveawayPins();
  }
}
