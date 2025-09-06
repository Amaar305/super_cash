import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

part 'fund_card_state.dart';

class FundCardCubit extends Cubit<FundCardState> {
  final String _cardId;
  final FundCardUseCase _fundCardUseCase;
  FundCardCubit({
    required String cardId,
    required FundCardUseCase fundCardUseCase,
  }) : _fundCardUseCase = fundCardUseCase,
       _cardId = cardId,
       super(FundCardState.initial());

  void resetState() => emit(FundCardState.initial());

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

  void onSubmit([void Function(TransactionResponse)? onSuccess]) async {
    final amount = Amount.dirty(state.amount.value);
    final isFormValid = FormzValid([amount]).isFormValid;

    final newState = state.copyWith(
      amount: amount,
      status: isFormValid ? FundCardStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    try {
      final res = await _fundCardUseCase(
        FundCardParams(amount: amount.value, cardId: _cardId),
      );
      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(status: FundCardStatus.failure, message: l.message),
        ),
        (r) {
          emit(state.copyWith(status: FundCardStatus.success));
          onSuccess?.call(r);
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
      state.copyWith(status: FundCardStatus.failure, message: error.toString()),
    );
  }
}
