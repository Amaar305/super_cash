import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  TransferCubit() : super(TransferState.initial());

  void resetState() => emit(TransferState.initial());

  void onSelectBank(String? bank) {
    if (state.selectedBank == bank) return;

    emit(
      state.copyWith(
        selectedBank: bank,
      ),
    );
  }

  void onSelectBankFocused() {
    final previousScreenState = state;
    final previousBankState = previousScreenState.selectedBank;

    final shouldValidate = previousBankState != null;
    if (shouldValidate) return;
    final newScreenState = previousScreenState.copyWith(
        selectedBankErrorMsg: 'This field is required');

    emit(newScreenState);
  }

  void onAccountNumberChanged(String newValue) {
    final previousScreenState = state;
    final previousAccountNumberState = previousScreenState.account;

    final shouldValidate = previousAccountNumberState.invalid;

    final newAccountNumberState =
        shouldValidate ? Account.dirty(newValue) : Account.pure(newValue);
    final newScreenState = previousScreenState.copyWith(
      account: newAccountNumberState,
    );

    emit(newScreenState);
  }

  void onAccountNumberFocused() {
    final previousScreenState = state;
    final previousAccountNumberState = previousScreenState.account;
    final previousAccountNumberValue = previousAccountNumberState.value;

    final newAccountNumberState = Account.dirty(previousAccountNumberValue);

    final newScreenState =
        previousScreenState.copyWith(account: newAccountNumberState);
    emit(newScreenState);
  }

  void onAmountChanged(String newValue) {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amount;

    final shouldValidate = previousAmountState.invalid;
    final newAmountState =
        shouldValidate ? Amount.dirty(newValue) : Amount.pure(newValue);

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

  void onValidateBank() async {
    final account = Account.dirty(state.account.value);
    final selectedBank = state.selectedBank;

    final isFormValid =
        FormzValid([account]).isFormValid && selectedBank != null;

    final newState = state.copyWith(
      account: account,
      selectedBank: selectedBank,
      selectedBankErrorMsg:
          selectedBank == null ? 'This field is required' : null,
      status: isFormValid ? TransferStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;
    final bankDetail = ValidatedBankDetail(
      bankName: selectedBank,
      accountName: 'Cool Data Plug',
      accountNumber: account.value,
    );

    try {
      await Future.delayed(Duration(seconds: 2));
      final newState = state.copyWith(
        status: TransferStatus.validated,
        bankDetail: bankDetail,
      );
      if (isClosed) return;
      emit(newState);
    } catch (error, stackTrace) {
      _errorFormatter(error, stackTrace);
    }
  }

  void onSubmit() async {
    final account = Account.dirty(state.account.value);
    final amount = Amount.dirty(state.amount.value);
    final selectedBank = state.selectedBank;
    final isFormValid =
        FormzValid([amount, account]).isFormValid && selectedBank != null;

    final newState = state.copyWith(
      account: account,
      amount: amount,
      selectedBank: selectedBank,
      status: isFormValid ? TransferStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;
    try {
      await Future.delayed(Duration(seconds: 2));
      final newState = state.copyWith(
        status: TransferStatus.success,
        selectedBankErrorMsg: null,
      );
      if (isClosed) return;
      emit(newState);
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
        status: TransferStatus.failure,
        message: error.toString(),
      ),
    );
  }
}
