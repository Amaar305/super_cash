import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';

part 'cable_state.dart';

class CableCubit extends Cubit<CableState> {
  final BuyCableUseCase _buyCableUseCase;
  final FetchCablePlanUseCase _fetchCablePlanUseCase;
  final ValidateCableUsecase _validateCableUsecase;
  CableCubit({
    required BuyCableUseCase buyCableUseCase,
    required FetchCablePlanUseCase fetchCablePlanUseCase,
    required ValidateCableUsecase validateCableUsecase,
  }) : _buyCableUseCase = buyCableUseCase,
       _fetchCablePlanUseCase = fetchCablePlanUseCase,
       _validateCableUsecase = validateCableUsecase,
       super(CableState.initial());

  void resetState() => emit(CableState.initial());

  void onProviderChanged(String provider) async {
    if (state.selectedProvider == provider) return;

    emit(
      state.copyWith(
        selectedProvider: provider,
        status: CableStatus.loading,
        forcePlanD: true,
      ),
    );

    final res = await _fetchCablePlanUseCase(
      CableParam(provider: provider.toLowerCase()),
    );

    res.fold(
      (l) {
        emit(state.copyWith(status: CableStatus.failure, message: l.message));
      },
      (r) {
        emit(state.copyWith(status: CableStatus.fetched, plans: r));
      },
    );
  }

  void _errorFormatter(Object error, StackTrace stackTrace) {
    emit(
      state.copyWith(message: error.toString(), status: CableStatus.failure),
    );
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
    final previousPhoneState = previousScreenState.cardNumber;
    final shouldValidate = previousPhoneState.invalid;

    final newPhoneState = shouldValidate
        ? Decoder.dirty(newValue)
        : Decoder.pure(newValue);

    final newScreenState = previousScreenState.copyWith(
      cardNumber: newPhoneState,
    );
    emit(newScreenState);
  }

  void onDecoderFocused() {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.cardNumber;
    final previousPhoneValue = previousPhoneState.value;

    final newPhoneState = Decoder.dirty(previousPhoneValue);

    final newScreenState = previousScreenState.copyWith(
      cardNumber: newPhoneState,
    );

    emit(newScreenState);
  }

  void onPurchaseCable([Function(String)? onSuccess]) async {
    final phone = Phone.dirty(state.phone.value);
    final decoder = Decoder.dirty(state.cardNumber.value);
    final provider = state.selectedProvider;
    final plan = state.plan;

    final isFormValid = FormzValid([phone, decoder]).isFormValid;

    if (plan == null) {
      final newState = state.copyWith(
        status: CableStatus.failure,
        message: 'Please select a plan',
        plan: plan,
      );
      emit(newState);
      return;
    }
    if (provider == null) {
      final newState = state.copyWith(
        status: CableStatus.failure,
        message: 'Please select Cable provider',
        plan: plan,
      );
      emit(newState);
      return;
    }
    if (!isFormValid) return;

    final newState = state.copyWith(
      cardNumber: decoder,
      phone: phone,
      selectedProvider: provider,
      status: isFormValid ? CableStatus.loading : null,
    );

    emit(newState);

    try {
      final res = await _buyCableUseCase(
        BuyCableUseParams(
          provider: provider,
          variationCode: plan['variation_code'],
          smartcardNumber: decoder.value,
          phone: phone.value,
        ),
      );
      if (isClosed) return;

      res.fold(
        (l) {
          emit(state.copyWith(status: CableStatus.failure, message: l.message));
        },
        (r) {
          emit(state.copyWith(status: CableStatus.success));
          onSuccess?.call(r['description']);
        },
      );
    } catch (error, stackTrace) {
      _errorFormatter(error, stackTrace);
    }
  }

  void onPlanSection(Map<String, dynamic> plan) =>
      emit(state.copyWith(plan: plan));
  void onValidateCable({
    void Function(Map<String, dynamic> result)? onVerified,
  }) async {
    // final amount = Amount.dirty(state.amount.value);
    final phone = Phone.dirty(state.phone.value);
    final decoder = Decoder.dirty(state.cardNumber.value);
    final plan = state.plan;
    final provider = state.selectedProvider;

    final isFormValid = FormzValid([phone, decoder]).isFormValid;

    if (plan == null) {
      final newState = state.copyWith(
        status: CableStatus.failure,
        message: 'Please select a plan',
        plan: plan,
      );
      emit(newState);
      return;
    }
    if (provider == null) {
      final newState = state.copyWith(
        status: CableStatus.failure,
        message: 'Please select Cable provider',
        plan: plan,
      );
      emit(newState);
      return;
    }
    if (!isFormValid) return;

    final newState = state.copyWith(
      status: isFormValid ? CableStatus.loading : null,
      plan: plan,
      phone: phone,
      selectedProvider: provider,
    );

    emit(newState);

    final res = await _validateCableUsecase(
      ValidateCableParam(provider: provider, smartcardNumber: decoder.value),
    );

    if (isClosed) return;

    res.fold(
      (l) =>
          emit(state.copyWith(status: CableStatus.failure, message: l.message)),
      (r) {
        emit(state.copyWith(status: CableStatus.validated));
        onVerified?.call(Map.from(r));
      },
    );

    // emit(newState.copyWith(status: CableStatus.success));
  }
}
