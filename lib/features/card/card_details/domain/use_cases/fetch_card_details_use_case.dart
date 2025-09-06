import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/card/card_details/card_details.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class CardDetailsUseCase implements UseCase<CardDetails, CardDetailsParams> {
  final CardDetailsRepositories cardDetailsRepositories;

  CardDetailsUseCase({required this.cardDetailsRepositories});

  @override
  Future<Either<Failure, CardDetails>> call(CardDetailsParams param) async {
    return await cardDetailsRepositories.getFullCardDetails(param.cardId);
  }
}

class CardDetailsParams {
  final String cardId;

  CardDetailsParams({required this.cardId});
}
