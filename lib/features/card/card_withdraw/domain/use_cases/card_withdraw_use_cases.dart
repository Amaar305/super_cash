import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/card/card_withdraw/domain/repository/card_withdraw_repositories.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class WithdrawFundUseCase
    implements UseCase<TransactionResponse, CardWithdrawParams> {
  final CardWithdrawRepositories cardWithdrawRepositories;

  WithdrawFundUseCase({required this.cardWithdrawRepositories});

  @override
  Future<Either<Failure, TransactionResponse>> call(
    CardWithdrawParams param,
  ) async {
    return cardWithdrawRepositories.cardWithdraw(
      amount: param.amount,
      cardId: param.cardId,
    );
  }
}

class FetchWalletBalanceUseCase implements UseCase<Wallet, NoParam> {
  final CardWithdrawRepositories cardWithdrawRepositories;

  FetchWalletBalanceUseCase({required this.cardWithdrawRepositories});

  @override
  Future<Either<Failure, Wallet>> call(NoParam param) async {
    return await cardWithdrawRepositories.fetchBalance();
  }
}

class CardWithdrawParams {
  final String amount;

  final String cardId;

  CardWithdrawParams({required this.amount, required this.cardId});
}
