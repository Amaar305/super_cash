import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart' hide Account;
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/bonus/bonus.dart';

part 'bonus_state.dart';

class BonusCubit extends Cubit<BonusState> {
  final FetchBankListUseCase _bankListUseCase;
  final ValidateBankUseCase _validateBankUseCase;
  final SendMoneyUseCase _sendMoneyUseCase;
  final WithdrawBonusUseCase _withdrawBonusUseCase;

  BonusCubit({
    required FetchBankListUseCase bankListUseCase,
    required ValidateBankUseCase validateBankUseCase,
    required SendMoneyUseCase sendMoneyUseCase,
    required WithdrawBonusUseCase withdrawBonusUseCase,
  }) : _bankListUseCase = bankListUseCase,
       _validateBankUseCase = validateBankUseCase,
       _sendMoneyUseCase = sendMoneyUseCase,
       _withdrawBonusUseCase = withdrawBonusUseCase,

       super(BonusState.initial());

  void resetState() => emit(BonusState.initial());

  void switchType({required bool withdraw}) {
    if (state.isBonusWithdrawn == withdraw || isClosed) return;

    emit(state.copyWith(isBonusWithdrawn: withdraw));
  }

  void onAccountNumberChanged(String newValue) {
    final previousScreenState = state;
    final previousAccountNumberState = previousScreenState.accountNumber;

    final shouldValidate = previousAccountNumberState.invalid;

    final newAccountNumberState = shouldValidate
        ? Account.dirty(newValue)
        : Account.pure(newValue);
    final newScreenState = previousScreenState.copyWith(
      accountNumber: newAccountNumberState,
    );

    emit(newScreenState);
  }

  void onAccountNumberFocused() {
    final previousScreenState = state;
    final previousAccountNumberState = previousScreenState.accountNumber;
    final previousAccountNumberValue = previousAccountNumberState.value;

    final newAccountNumberState = Account.dirty(previousAccountNumberValue);

    final newScreenState = previousScreenState.copyWith(
      accountNumber: newAccountNumberState,
    );
    emit(newScreenState);
  }

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

  void onAccountNameChanged(String newValue) {
    final previousScreenState = state;
    final previousAccountNumberState = previousScreenState.accountName;

    final shouldValidate = previousAccountNumberState.invalid;

    final newAccountNumberState = shouldValidate
        ? FullName.dirty(newValue)
        : FullName.pure(newValue);
    final newScreenState = previousScreenState.copyWith(
      accountName: newAccountNumberState,
    );

    emit(newScreenState);
  }

  void onAccountNameFocused() {
    final previousScreenState = state;
    final previousAccountNumberState = previousScreenState.accountName;
    final previousAccountNumberValue = previousAccountNumberState.value;

    final newAccountNumberState = FullName.dirty(previousAccountNumberValue);

    final newScreenState = previousScreenState.copyWith(
      accountName: newAccountNumberState,
    );
    emit(newScreenState);
  }

  void onBankSelected(Bank bank) => emit(state.copyWith(selectedBank: bank));

  Future<void> fetchBankList() async {
    if (isClosed) return;

    emit(state.copyWith(status: BonusStatus.loading));

    try {
      final res = await _bankListUseCase(NoParam());
      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(status: BonusStatus.failure, message: l.message),
        ),
        (bankList) => emit(
          state.copyWith(status: BonusStatus.loaded, bankList: bankList),
        ),
      );
    } catch (error, stackTrace) {
      logE('Failed to fetch bank list', error: error, stackTrace: stackTrace);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: BonusStatus.failure,
          message: 'Failed to fetch bank list. Please try again.',
        ),
      );
    }
  }

  Future<void> validateBank(
    void Function(ValidatedBank result) onSuccess,
  ) async {
    final accountNumber = Account.dirty(state.accountNumber.value);
    final selectedBank = state.selectedBank;
    final isFormValid =
        FormzValid([accountNumber]).isFormValid && selectedBank != null;

    emit(
      state.copyWith(
        accountNumber: accountNumber,
        status: isFormValid ? BonusStatus.loading : null,
        message: selectedBank == null ? 'Please select a bank' : '',
      ),
    );

    if (!isFormValid) return;

    try {
      final res = await _validateBankUseCase(
        ValidateBankParams(
          bankCode: selectedBank.bankCode,
          accountNumber: accountNumber.value,
        ),
      );

      if (isClosed) return;

      res.fold(
        (failure) => emit(
          state.copyWith(status: BonusStatus.failure, message: failure.message),
        ),
        (validatedBank) {
          emit(
            state.copyWith(
              status: BonusStatus.validated,
              bankValidationResult: validatedBank,
              accountName: FullName.dirty(validatedBank.accountName),
              message: '',
            ),
          );
          onSuccess(validatedBank);
        },
      );
    } catch (error, stackTrace) {
      logE('Failed to validate bank', error: error, stackTrace: stackTrace);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: BonusStatus.failure,
          message: 'Failed to validate bank. Please try again.',
        ),
      );
    }
  }

  Future<void> sendMoney() async {
    final amount = Amount.dirty(state.amount.value);
    final accountNumber = Account.dirty(state.accountNumber.value);
    final accountName = FullName.dirty(state.accountName.value);
    final selectedBank = state.selectedBank;
    final validatedDetail = state.bankValidationResult;

    final isFormValid =
        FormzValid([amount, accountNumber, accountName]).isFormValid &&
        selectedBank != null &&
        validatedDetail != null;

    emit(
      state.copyWith(
        amount: amount,
        accountNumber: accountNumber,
        accountName: accountName,
        status: isFormValid ? BonusStatus.loading : null,
        message: selectedBank == null
            ? 'Please select a bank'
            : validatedDetail == null
            ? 'Please validate bank details'
            : '',
      ),
    );

    if (!isFormValid) return;

    try {
      final result = await _sendMoneyUseCase(
        SendMoneyParams(
          accountNumber: accountNumber.value,
          bankCode: selectedBank.bankCode,
          amount: amount.value,
          accountName: validatedDetail.accountName,
        ),
      );

      if (isClosed) return;

      result.fold(
        (failure) => emit(
          state.copyWith(status: BonusStatus.failure, message: failure.message),
        ),
        (response) => emit(
          state.copyWith(
            status: BonusStatus.transferred,
            message:
                response['message'] as String? ??
                'Transfer completed successfully.',
          ),
        ),
      );
    } catch (error, stackTrace) {
      logE('Failed to send money', error: error, stackTrace: stackTrace);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: BonusStatus.failure,
          message: 'Failed to send money. Please try again.',
        ),
      );
    }
  }

  Future<void> withdrawBonus() async {
    final amount = Amount.dirty(state.amount.value);
    final isFormValid = FormzValid([amount]).isFormValid;

    emit(
      state.copyWith(
        amount: amount,
        status: isFormValid ? BonusStatus.loading : null,
      ),
    );

    if (!isFormValid) return;

    try {
      final result = await _withdrawBonusUseCase(
        WithdrawBonusParams(amount: amount.value),
      );

      if (isClosed) return;

      result.fold(
        (failure) => emit(
          state.copyWith(status: BonusStatus.failure, message: failure.message),
        ),
        (response) => emit(
          state.copyWith(
            status: BonusStatus.withdrawn,
            message:
                response['message'] as String? ??
                'Withdrawal completed successfully.',
          ),
        ),
      );
    } catch (error, stackTrace) {
      logE('Failed to withdraw bonus', error: error, stackTrace: stackTrace);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: BonusStatus.failure,
          message: 'Failed to withdraw bonus. Please try again.',
        ),
      );
    }
  }
}
