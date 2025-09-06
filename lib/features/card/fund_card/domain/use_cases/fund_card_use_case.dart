import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/card/fund_card/fund_card.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class FundCardUseCase implements UseCase<TransactionResponse, FundCardParams> {
  final FundCardRepositories fundCardRepositories;

  FundCardUseCase({required this.fundCardRepositories});

  @override
  Future<Either<Failure, TransactionResponse>> call(
    FundCardParams param,
  ) async {
    return await fundCardRepositories.fundCard(
      amount: param.amount,
      cardId: param.cardId,
    );
  }
}

class FundCardParams {
  final String amount;
  final String cardId;

  FundCardParams({required this.amount, required this.cardId});
}
