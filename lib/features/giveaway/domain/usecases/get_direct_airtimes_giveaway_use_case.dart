import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GetDirectAirtimesGiveawayUseCase
    implements UseCase<List<DirectAirtimeModel>, NoParam> {
  final GiveawayRepository giveawayRepository;

  const GetDirectAirtimesGiveawayUseCase({required this.giveawayRepository});

  @override
  Future<Either<Failure, List<DirectAirtimeModel>>> call(NoParam param) async {
    return await giveawayRepository.getDirectAirtimesGiveaway();
  }
}
