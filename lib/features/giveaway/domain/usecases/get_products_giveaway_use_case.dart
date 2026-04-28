import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GetProductsGiveawayUseCase implements UseCase<List<ProductGiveawayModel>, NoParam> {
  final GiveawayRepository giveawayRepository;

  const GetProductsGiveawayUseCase({required this.giveawayRepository});

  @override
  Future<Either<Failure, List<ProductGiveawayModel>>> call(NoParam param) async {
    return giveawayRepository.getProductsGiveaway();
  }
}
