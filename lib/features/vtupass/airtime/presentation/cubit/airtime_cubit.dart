import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../airtime.dart';

part 'airtime_state.dart';

class AirtimeCubit extends Cubit<AirtimeState> {
  final AirtimeUsecase _airtimeUsecase;
  AirtimeCubit({required AirtimeUsecase airtimeUsecase})
      : _airtimeUsecase = airtimeUsecase,
        super(AirtimeState.initial());

  void resetState() => emit(AirtimeState.initial());
  void onNetworkChanged(String network) =>
      emit(state.copyWith(selectedNetwork: network));

  void onAmountChanged(String newValue) {
    final previousScreenState = state;
    final previoustAmountState = previousScreenState.amount;
    final shouldValidate = previoustAmountState.invalid;
    final commaOrSpace = RegExp(r'[, ]');

    final amountValue = newValue.replaceAll(commaOrSpace, "");
    final newAmountState =
        shouldValidate ? Amount.dirty(amountValue) : Amount.pure(amountValue);

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

    final newPhoneState =
        shouldValidate ? Phone.dirty(newValue) : Phone.pure(newValue);

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

  void onToggleShowPassword(bool vtuSell) {
    if (state.vtuSell == vtuSell) return;
    emit(state.copyWith(vtuSell: vtuSell));
  }

  // Validate the fields
  void onValidate([void Function()? onSuccess]) {
    final amount = Amount.dirty(state.amount.value);
    final phone = Phone.dirty(state.phone.value);
    final network = state.selectedNetwork;
    final isFormValid = FormzValid([amount, phone]).isFormValid &&
        const ['MTN', 'Airtel', '9Mobile', 'Glo'].contains(network);

    final newState = state.copyWith(
      amount: amount,
      phone: phone,
      selectedNetwork: network,
      status: isFormValid ? AirtimeStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    onSuccess?.call();
  }

  void onSubmit([Function(TransactionResponse)? onSuccess]) async {
    final amount = Amount.dirty(state.amount.value);
    final phone = Phone.dirty(state.phone.value);
    final network = state.selectedNetwork;
    final isFormValid = FormzValid([amount, phone]).isFormValid &&
        const ['MTN', 'Airtel', '9Mobile', 'Glo'].contains(network);

    final newState = state.copyWith(
      amount: amount,
      phone: phone,
      selectedNetwork: network,
      status: isFormValid ? AirtimeStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    try {
      final res = await _airtimeUsecase(
        AirtimeParam(
          mobileNumber: phone.value,
          amount: amount.value,
          network: network!,
        ),
      );

      if (isClosed) return;

      res.fold(
        (l) => emit(
            state.copyWith(status: AirtimeStatus.failure, message: l.message)),
        (r) {
          emit(newState.copyWith(
            status: AirtimeStatus.success,
            response: r,
          ));
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
      state.copyWith(
        status: AirtimeStatus.failure,
        message: error.toString(),
      ),
    );
  }
}
