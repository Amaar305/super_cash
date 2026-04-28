import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart' hide Account;
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/bonus/bonus.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

part 'cash_giveaway_state.dart';

class CashGiveawayCubit extends Cubit<CashGiveawayState> {
  final GetCashGiveawaysUseCase _getCashGiveawaysUseCase;
  final ClaimCashGiveawayUseCase _claimCashGiveawayUseCase;
  final AddCashAccountDetailsUseCase _addCashAccountDetailsUseCase;
  final FetchBankListUseCase _fetchBankListUseCase;
  final ValidateBankUseCase _validateBankUseCase;
  final String _giveawayTypeId;

  CashGiveawayCubit({
    required GetCashGiveawaysUseCase getCashGiveawaysUseCase,
    required ClaimCashGiveawayUseCase claimCashGiveawayUseCase,
    required AddCashAccountDetailsUseCase addCashAccountDetailsUseCase,
    required String giveawayTypeId,
    required FetchBankListUseCase fetchBankListUseCase,
    required ValidateBankUseCase validateBankUseCase,
  }) : _addCashAccountDetailsUseCase = addCashAccountDetailsUseCase,
       _claimCashGiveawayUseCase = claimCashGiveawayUseCase,
       _getCashGiveawaysUseCase = getCashGiveawaysUseCase,
       _giveawayTypeId = giveawayTypeId,
       _fetchBankListUseCase = fetchBankListUseCase,
       _validateBankUseCase = validateBankUseCase,
       super(CashGiveawayState.initial());

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

  void onBankSelected(Bank? bank) => emit(state.copyWith(selectedBank: bank));

  Future<void> fetchBankList() async {
    if (isClosed) return;

    emit(state.copyWith(status: CashGiveawayStatus.loading));

    try {
      final res = await _fetchBankListUseCase(NoParam());
      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(
            status: CashGiveawayStatus.failure,
            message: l.message,
          ),
        ),
        (bankList) => emit(
          state.copyWith(
            status: CashGiveawayStatus.loadedBanks,
            bankList: bankList,
          ),
        ),
      );
    } catch (error, stackTrace) {
      logE('Failed to fetch bank list', error: error, stackTrace: stackTrace);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: CashGiveawayStatus.failure,
          message: 'Failed to fetch bank list. Please try again.',
        ),
      );
    }
  }

  Future<void> validateBank([
    void Function(ValidatedBank result)? onSuccess,
  ]) async {
    final accountNumber = Account.dirty(state.accountNumber.value);
    final selectedBank = state.selectedBank;
    final isFormValid =
        FormzValid([accountNumber]).isFormValid && selectedBank != null;

    emit(
      state.copyWith(
        accountNumber: accountNumber,
        status: isFormValid ? CashGiveawayStatus.loading : null,
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
          state.copyWith(
            status: CashGiveawayStatus.failure,
            message: failure.message,
          ),
        ),
        (validatedBank) {
          emit(
            state.copyWith(
              status: CashGiveawayStatus.validatedBank,
              bankValidationResult: validatedBank,

              message: '',
            ),
          );
          onSuccess?.call(validatedBank);
        },
      );
    } catch (error, stackTrace) {
      logE('Failed to validate bank', error: error, stackTrace: stackTrace);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: CashGiveawayStatus.failure,
          message: 'Failed to validate bank. Please try again.',
        ),
      );
    }
  }

  Future<void> getCashGiveaways() async {
    emit(state.copyWith(status: CashGiveawayStatus.loading));

    final res = await _getCashGiveawaysUseCase(NoParam());
    if (isClosed) return;

    res.fold(
      (l) => emit(
        state.copyWith(message: l.message, status: CashGiveawayStatus.failure),
      ),
      (r) => emit(
        state.copyWith(
          message: '',
          giveaways: r,
          status: CashGiveawayStatus.loaded,
        ),
      ),
    );
  }

  Future<void> claimGiveaway(
    String cashId, {

    required void Function(CashGiveawayItem cash) onClaimed,
  }) async {
    emit(state.copyWith(status: CashGiveawayStatus.loading));

    final res = await _claimCashGiveawayUseCase(
      ClaimCashGiveawayParams(cashId: cashId, giveawayTypeId: _giveawayTypeId),
    );
    if (isClosed) return;

    res.fold(
      (failure) => emit(
        state.copyWith(
          status: CashGiveawayStatus.failure,
          message: failure.message,
        ),
      ),
      (cash) {
        emit(
          state.copyWith(
            status: CashGiveawayStatus.claimed,
            message: '',
            giveaways: state.giveaways.map((item) {
              return item.id == cash.id ? cash : item;
            }).toList(),
          ),
        );
        onClaimed(cash);
      },
    );
  }

  Future<void> addCashAccountDetails(
    String cashId, {
    required Function(UserCashAccountDetailModel account) onAdded,
  }) async {
    final accountNumber = Account.dirty(state.accountNumber.value);
    final selectedBank = state.selectedBank;
    final validatedDetail = state.bankValidationResult;

    final isFormValid =
        FormzValid([accountNumber]).isFormValid &&
        selectedBank != null &&
        validatedDetail != null;

    emit(
      state.copyWith(
        accountNumber: accountNumber,
        status: isFormValid ? CashGiveawayStatus.loading : null,
        message: selectedBank == null
            ? 'Please select a bank'
            : validatedDetail == null
            ? 'Please validate bank details'
            : '',
      ),
    );

    if (!isFormValid) return;

    try {
      final res = await _addCashAccountDetailsUseCase(
        AddCashAccountDetailsParams(
          cashId: cashId,
          accountName: validatedDetail.accountName,
          accountNumber: accountNumber.value,
          bankName: selectedBank.bankName,
          bankCode: selectedBank.bankCode,
        ),
      );

      if (isClosed) return;

      res.fold(
        (failure) => emit(
          state.copyWith(
            status: CashGiveawayStatus.failure,
            message: failure.message,
          ),
        ),
        (account) {
          emit(
            state.copyWith(status: CashGiveawayStatus.finished, message: ''),
          );
          onAdded(account);
        },
      );
    } catch (error, stackTrace) {
      logE(
        'Failed to add cash account details',
        error: error,
        stackTrace: stackTrace,
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          status: CashGiveawayStatus.failure,
          message: 'Failed to add account details. Please try again.',
        ),
      );
    }
  }
}
