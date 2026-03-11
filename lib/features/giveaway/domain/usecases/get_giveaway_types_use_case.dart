import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GetGiveawayTypesUseCase implements UseCase<List<GiveawayType>, NoParam> {
  final GiveawayRepository giveawayRepository;

  const GetGiveawayTypesUseCase({required this.giveawayRepository});

  @override
  Future<Either<Failure, List<GiveawayType>>> call(NoParam param) async {
    return await giveawayRepository.getGiveawaytypes();
  }
}
