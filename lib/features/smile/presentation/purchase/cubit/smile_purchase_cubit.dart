import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/smile/domain/domain.dart';

part 'smile_purchase_state.dart';

/// Owns the second step: verifying the Smile email, picking which linked
/// account to fund, entering a phone number and purchasing the plan chosen
/// on the previous page. The plan itself is fixed for the lifetime of this
/// cubit — it can't be changed here, only on the plan-selection page.
class SmilePurchaseCubit extends Cubit<SmilePurchaseState> {
  final VerifySmileEmailUseCase _verifySmileEmailUseCase;
  final PurchaseSmilePlanUseCase _purchaseSmilePlanUseCase;
  final QuerySmileTransactionStatusUseCase _queryTransactionStatusUseCase;

  SmilePurchaseCubit({
    required SmilePlan plan,
    required VerifySmileEmailUseCase verifySmileEmailUseCase,
    required PurchaseSmilePlanUseCase purchaseSmilePlanUseCase,
    required QuerySmileTransactionStatusUseCase queryTransactionStatusUseCase,
  }) : _verifySmileEmailUseCase = verifySmileEmailUseCase,
       _purchaseSmilePlanUseCase = purchaseSmilePlanUseCase,
       _queryTransactionStatusUseCase = queryTransactionStatusUseCase,
       super(SmilePurchaseState.initial(plan));

  void onEmailChanged(String newValue) {
    final previousEmailState = state.email;
    final shouldValidate = previousEmailState.invalid;

    final newEmailState = shouldValidate
        ? Email.dirty(newValue)
        : Email.pure(newValue);

    // Editing the email invalidates any account picked from a previous
    // verification, so the purchase gate re-requires verification.
    emit(state.copyWith(email: newEmailState, forceVerificationClear: true));
  }

  void onEmailFocused() {
    emit(state.copyWith(email: Email.dirty(state.email.value)));
  }

  void onPhoneChanged(String newValue) {
    final previousPhoneState = state.phone;
    final shouldValidate = previousPhoneState.invalid;

    final newPhoneState = shouldValidate
        ? Phone.dirty(newValue)
        : Phone.pure(newValue);

    emit(state.copyWith(phone: newPhoneState));
  }

  void onPhoneFocused() {
    emit(state.copyWith(phone: Phone.dirty(state.phone.value)));
  }

  void onAccountSelected(SmileAccount account) =>
      emit(state.copyWith(selectedAccount: account));

  Future<void> verifyEmail() async {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(email: email, status: SmilePurchaseStatus.loading));

    final res = await _verifySmileEmailUseCase(
      VerifySmileEmailParams(email: email.value),
    );
    if (isClosed) return;

    res.fold(
      (l) => emit(
        state.copyWith(status: SmilePurchaseStatus.failure, message: l.message),
      ),
      (r) => emit(
        state.copyWith(
          status: SmilePurchaseStatus.verified,
          customerName: r.customerName,
          accounts: r.accounts,
          selectedAccount: r.accounts.length == 1 ? r.accounts.first : null,
        ),
      ),
    );
  }

  Future<void> purchase({
    void Function(TransactionResponse transaction)? onSuccess,
  }) async {
    final account = state.selectedAccount;
    if (account == null) return;

    emit(state.copyWith(status: SmilePurchaseStatus.loading));

    final res = await _purchaseSmilePlanUseCase(
      PurchaseSmilePlanParams(
        email: state.email.value,
        accountId: account.accountId,
        variationCode: state.plan.variationCode,
        phone: state.phone.value,
      ),
    );
    if (isClosed) return;

    res.fold(
      (l) => emit(
        state.copyWith(status: SmilePurchaseStatus.failure, message: l.message),
      ),
      (r) {
        emit(state.copyWith(status: SmilePurchaseStatus.success));
        onSuccess?.call(r);
      },
    );
  }

  Future<void> checkTransactionStatus(
    String reference, {
    required void Function(SmileTransactionStatus result) onResult,
    void Function(String message)? onError,
  }) async {
    final res = await _queryTransactionStatusUseCase(
      QuerySmileTransactionStatusParams(reference: reference),
    );
    if (isClosed) return;

    res.fold((l) => onError?.call(l.message), onResult);
  }
}
