import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../card_details.dart';

class FreezeCardUseCase
    implements UseCase<CardActionResponse, FreezeCardParam> {
  final CardDetailsRepositories cardDetailsRepositories;

  FreezeCardUseCase({required this.cardDetailsRepositories});

  @override
  Future<Either<Failure, CardActionResponse>> call(
    FreezeCardParam param,
  ) async {
    return await cardDetailsRepositories.freezeCard(
      param.cardId,
      unfreeze: param.unfreeze,
    );
  }
}

class FreezeCardParam {
  final String cardId;
  final bool unfreeze;

  FreezeCardParam({required this.cardId, this.unfreeze = false});
}
