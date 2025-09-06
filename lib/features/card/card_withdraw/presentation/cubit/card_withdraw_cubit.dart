import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../domain/use_cases/card_withdraw_use_cases.dart';

part 'card_withdraw_state.dart';

class CardWithdrawCubit extends Cubit<CardWithdrawState> {
  final String _cardId;
  final WithdrawFundUseCase _withdrawFundUseCase;
  final FetchWalletBalanceUseCase _walletBalanceUseCase;

  CardWithdrawCubit({
    required String cardId,
    required WithdrawFundUseCase withdrawFundUseCase,
    required FetchWalletBalanceUseCase walletBalanceUseCase,
  }) : _cardId = cardId,
       _walletBalanceUseCase = walletBalanceUseCase,
       _withdrawFundUseCase = withdrawFundUseCase,
       super(CardWithdrawState.initial());
  void resetState() => emit(CardWithdrawState.initial());

  void onAmountChanged(String newValue) {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amount;

    final shouldValidate = previousAmountState.invalid;

    final newAmountState = shouldValidate
        ? Amount.dirty(newValue)
        : Amount.pure(newValue);

    final newScreenState = previousScreenState.copyWith(amount: newAmountState);

    emit(newScreenState);
  }

  void onAmountFocused() {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amount;

    final previousAmountValue = previousAmountState.value;

    final newAmountState = Amount.dirty(previousAmountValue);

    final newScreenState = previousScreenState.copyWith(amount: newAmountState);

    emit(newScreenState);
  }

  void onFetchWalletBalance() async {
    emit(state.copyWith(status: CardWithdrawStatus.loading));

    final res = await _walletBalanceUseCase(NoParam());

    if (isClosed) return;

    res.fold(
      (l) => emit(
        state.copyWith(message: l.message, status: CardWithdrawStatus.failure),
      ),
      (r) =>
          emit(state.copyWith(wallet: r, status: CardWithdrawStatus.success)),
    );
  }

  void onSubmit([void Function(TransactionResponse)? onSuccess]) async {
    final amount = Amount.dirty(state.amount.value);
    final isFormValid = FormzValid([amount]).isFormValid;

    final newState = state.copyWith(
      amount: amount,
      status: isFormValid ? CardWithdrawStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    try {
      final res = await _withdrawFundUseCase(
        CardWithdrawParams(amount: amount.value, cardId: _cardId),
      );

      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(
            status: CardWithdrawStatus.failure,
            message: l.message,
          ),
        ),
        (r) {
          emit(state.copyWith(status: CardWithdrawStatus.success));

          onSuccess?.call(r);
          onFetchWalletBalance();
        },
      );
    } catch (error, stackTrace) {
      _errorFormatter(error, stackTrace);
    }
  }

  void _errorFormatter(Object error, StackTrace stackTrace) {
    addError(error, stackTrace);
    // final status = switch (error) {
    //   AuthException(:final statusCode) => switch (statusCode?.parse) {
    //       HttpStatus.tooManyRequests => ForgotPasswordStatus.tooManyRequests,
    //       _ => ForgotPasswordStatus.failure,
    //     },
    //   _ => ForgotPasswordStatus.failure,
    // };

    emit(
      state.copyWith(
        status: CardWithdrawStatus.failure,
        message: error.toString(),
      ),
    );
  }
}
