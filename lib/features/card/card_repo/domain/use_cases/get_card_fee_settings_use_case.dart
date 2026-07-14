import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/card/card_repo/card_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class GetCardFeeSettingsUseCase implements UseCase<CardFeeSettings, NoParam> {
  final CardRepositories cardRepositories;

const  GetCardFeeSettingsUseCase({required this.cardRepositories});

  @override
  Future<Either<Failure, CardFeeSettings>> call(NoParam param) async {
    return await cardRepositories.getCardFeeSettings();
  }
}
