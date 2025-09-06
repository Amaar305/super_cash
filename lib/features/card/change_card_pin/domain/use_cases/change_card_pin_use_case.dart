import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:fpdart/fpdart.dart';

class ChangeCardPinUseCase
    implements UseCase<Map<String, dynamic>, ChangeCardParams> {
  final ChangeCardPinRepositories changeCardPinRepositories;

  ChangeCardPinUseCase({required this.changeCardPinRepositories});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    ChangeCardParams param,
  ) async {
    return await changeCardPinRepositories.changeCardPin(
      pin: param.pin,
      cardId: param.cardId,
    );
  }
}

class ChangeCardParams {
  final String pin;
  final String cardId;

  ChangeCardParams({required this.pin, required this.cardId});
}
