import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

part 'electricity_state.dart';

class ElectricityCubit extends Cubit<ElectricityState> {
  final GetElectricityPlansUseCase _getElectricityPlansUseCase;
  final ValidateElectricityPlanUseCase _validateElectricityPlanUseCase;
  final PurchaseElectricityPlanUseCase _purchaseElectricityPlanUseCase;

  ElectricityCubit({
    required GetElectricityPlansUseCase getElectricityPlansUseCase,
    required ValidateElectricityPlanUseCase validateElectricityPlanUseCase,
    required PurchaseElectricityPlanUseCase purchaseElectricityPlanUseCase,
  }) : _getElectricityPlansUseCase = getElectricityPlansUseCase,
       _purchaseElectricityPlanUseCase = purchaseElectricityPlanUseCase,
       _validateElectricityPlanUseCase = validateElectricityPlanUseCase,
       super(ElectricityState.initial());

  void resetState() => emit(ElectricityState.initial());

  void onTypeChanged(bool type) {
    if (state.prepaid == type) return;

    emit(state.copyWith(prepaid: type));
  }

  void onStart() async {
    if (isClosed) return;
    emit(state.copyWith(status: ElectricityStatus.loading));
    try {
      final res = await _getElectricityPlansUseCase(NoParam());

      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(status: ElectricityStatus.failure, message: l.message),
        ),
        (r) =>
            emit(state.copyWith(plans: r, status: ElectricityStatus.success)),
      );
    } catch (error, stackTrace) {
      logE('Failed to fetch plans $error', stackTrace: stackTrace);
      if (isClosed) return;
      final res = await _getElectricityPlansUseCase(NoParam());

      res.fold(
        (l) => emit(
          state.copyWith(status: ElectricityStatus.failure, message: l.message),
        ),
        (r) =>
            emit(state.copyWith(plans: r, status: ElectricityStatus.success)),
      );
    }
  }

  void onPlanSelection(Electricity plan) =>
      emit(state.copyWith(selectedPlan: plan));
  void onAmountChanged(String newValue) {
    final previousScreenState = state;
    final previoustAmountState = previousScreenState.amount;
    final shouldValidate = previoustAmountState.invalid;
    final commaOrSpace = RegExp(r'[, ]');

    final amountValue = newValue.replaceAll(commaOrSpace, "");
    final newAmountState = shouldValidate
        ? Amount.dirty(amountValue)
        : Amount.pure(amountValue);

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

  void onPhoneChanged(String newValue) {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.phone;
    final shouldValidate = previousPhoneState.invalid;

    final newPhoneState = shouldValidate
        ? Phone.dirty(newValue)
        : Phone.pure(newValue);

    final newScreenState = previousScreenState.copyWith(phone: newPhoneState);
    emit(newScreenState);
  }

  void onPhoneFocused() {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.phone;
    final previousPhoneValue = previousPhoneState.value;

    final newPhoneState = Phone.dirty(previousPhoneValue);

    final newScreenState = previousScreenState.copyWith(phone: newPhoneState);

    emit(newScreenState);
  }

  void onDecoderChanged(String newValue) {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.meter;
    final shouldValidate = previousPhoneState.invalid;

    final newPhoneState = shouldValidate
        ? Decoder.dirty(newValue)
        : Decoder.pure(newValue);

    final newScreenState = previousScreenState.copyWith(meter: newPhoneState);
    emit(newScreenState);
  }

  void onDecoderFocused() {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.meter;
    final previousPhoneValue = previousPhoneState.value;

    final newPhoneState = Decoder.dirty(previousPhoneValue);

    final newScreenState = previousScreenState.copyWith(meter: newPhoneState);

    emit(newScreenState);
  }

  Future<void> validateFields(Future<void> Function() onValidated) async {
    final meter = Decoder.dirty(state.meter.value);
    final phone = Phone.dirty(state.phone.value);
    final amount = Amount.dirty(state.amount.value);
    final hasPlan = state.selectedPlan != null;
    final isFormValid =
        hasPlan && FormzValid([meter, phone, amount]).isFormValid;

    emit(
      state.copyWith(
        meter: meter,
        phone: phone,
        amount: amount,
        status: isFormValid ? ElectricityStatus.loading : null,
        message: isFormValid ? '' : state.message,
      ),
    );

    if (!isFormValid) return;

    await onValidated();
  }

  Future<void> onElectricityValidation({
    void Function(ElectricityValidationResult)? onVerified,
  }) async {
    await validateFields(() async {
      final selectedPlan = state.selectedPlan!;
      final meterValue = state.meter.value;
      final type = state.prepaid ? 'prepaid' : 'postpaid';

      final res = await _validateElectricityPlanUseCase(
        ValidateElectricityPlanParams(
          billersCode: meterValue,
          serviceID: selectedPlan.discoId,
          type: type,
        ),
      );

      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(message: l.message, status: ElectricityStatus.failure),
        ),
        (r) {
          emit(
            state.copyWith(
              status: ElectricityStatus.validated,
              electricityValidationResult: r,
            ),
          );
          onVerified?.call(r);
        },
      );
    });
  }

  void onElectrityPurchase({
    void Function(TransactionResponse)? onPurchased,
  }) async {
    final selectedPlan = state.selectedPlan;
    final type = state.prepaid;
    final meter = Decoder.dirty(state.meter.value);
    final amount = Amount.dirty(state.amount.value);
    final phone = Phone.dirty(state.phone.value);

    final isFormValid = FormzValid([meter, amount, phone]).isFormValid;

    if (selectedPlan == null || !isFormValid) return;
    emit(
      state.copyWith(
        selectedPlan: selectedPlan,
        prepaid: type,
        meter: meter,
        status: isFormValid ? ElectricityStatus.loading : null,
      ),
    );
    final res = await _purchaseElectricityPlanUseCase(
      PurchaseElectricityPlanParams(
        billersCode: meter.value,
        serviceID: selectedPlan.discoId,
        type: type ? "prepaid" : "postpaid",
        amount: amount.value,
        phone: phone.value,
      ),
    );

    res.fold(
      (l) => emit(
        state.copyWith(status: ElectricityStatus.failure, message: l.message),
      ),
      (r) {
        emit(state.copyWith(status: ElectricityStatus.purchased, transactionResponse: r));
        onPurchased?.call(r);
      },
    );
  }
}
