import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:fpdart/fpdart.dart';

class CreateCardUseCases
    implements UseCase<Map<String, dynamic>, CreateCardParams> {
  final CreateCardRepositories createCardRepositories;

  CreateCardUseCases({required this.createCardRepositories});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    CreateCardParams param,
  ) async {
    return await createCardRepositories.createVirtualCard(
      pin: param.pin,
      cardLimit: param.cardLimit,
      amount: param.amount,
      cardBrand: param.cardBrand,
    );
  }
}

class CreateCardParams {
  final String pin;
  final String cardLimit;
  final String amount;
  final String cardBrand;

  CreateCardParams({
    required this.pin,
    required this.cardLimit,
    required this.amount,
    required this.cardBrand,
  });
}
