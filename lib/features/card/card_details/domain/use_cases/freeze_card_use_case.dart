import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../../card_details.dart';

class FreezeCardUseCase
    implements UseCase<Map<String, dynamic>, FreezeCardParam> {
  final CardDetailsRepositories cardDetailsRepositories;

  FreezeCardUseCase({required this.cardDetailsRepositories});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    FreezeCardParam param,
  ) async {
    return await cardDetailsRepositories.freezeCard(param.cardId);
  }
}

class FreezeCardParam {
  final String cardId;

  FreezeCardParam({required this.cardId});
}
