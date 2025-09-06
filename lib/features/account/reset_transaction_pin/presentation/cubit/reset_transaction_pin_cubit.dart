import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/account/manage_transaction_pin/manage_transaction_pin.dart';

part 'reset_transaction_pin_state.dart';

class ResetTransactionPinCubit extends Cubit<ResetTransactionPinState> {
  ResetTransactionPinCubit({
    required ResetTransactionPinUseCase resetTransactionPinUseCase,
    required AppUser user,
    required RequestTransactionPinOtpUseCase requestTransactionPinOtpUseCase,
  }) : _resetTransactionPinUseCase = resetTransactionPinUseCase,
       _user = user,
       _requestTransactionPinOtpUseCase = requestTransactionPinOtpUseCase,
       super(ResetTransactionPinState.initial());

  final ResetTransactionPinUseCase _resetTransactionPinUseCase;
  final RequestTransactionPinOtpUseCase _requestTransactionPinOtpUseCase;

  final AppUser _user;

  void onOtpChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.otp;
    final shouldValidate = previousPinState.invalid;

    final newPinState = shouldValidate ? Otp2.dirty(value) : Otp2.dirty(value);

    final newScreenState = previousScreenState.copyWith(otp: newPinState);

    emit(newScreenState);
  }

  void onNewPinChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.newPin;
    final shouldValidate = previousPinState.invalid;

    final newPinState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState = previousScreenState.copyWith(newPin: newPinState);

    emit(newScreenState);
  }

  void onConfirmPinChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.confirmPin;
    final shouldValidate = previousPinState.invalid;

    final didMatched = value == previousScreenState.newPin.value;

    final newPinState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState = previousScreenState.copyWith(
      confirmPin: newPinState,
      confirmPinMessage: !didMatched ? 'Pin does not match' : '',
    );

    emit(newScreenState);
  }

  void requestOtp(VoidCallback onSend) async {
    try {
      if (isClosed || state.status.isLoading) return;

      emit(state.copyWith(status: ResetTransactionPinStatus.loading));

      final res = await _requestTransactionPinOtpUseCase(
        RequestTransactionPinOtpParam(email: _user.email),
      );

      res.fold(
        (l) => emit(
          state.copyWith(
            status: ResetTransactionPinStatus.failure,
            message: l.message,
          ),
        ),
        (r) {
          emit(state.copyWith(status: ResetTransactionPinStatus.success));
          onSend.call();
        },
      );
    } catch (e) {
      emit(state.copyWith(status: ResetTransactionPinStatus.failure));
    }
  }

  Future<void> submit(VoidCallback onSubmit) async {
    final newPin = Otp.dirty(state.newPin.value);
    final otp = Otp2.dirty(state.otp.value);
    final confirmPin = Otp.dirty(state.confirmPin.value);
    final didMatched = newPin.value == confirmPin.value;

    final isFormValid =
        FormzValid([newPin, confirmPin, otp]).isFormValid && didMatched;

    final newState = state.copyWith(
      newPin: newPin,
      confirmPin: confirmPin,
      status: isFormValid ? ResetTransactionPinStatus.loading : null,
    );

    emit(newState);
    if (!isFormValid || isClosed) return;

    try {
      final res = await _resetTransactionPinUseCase(
        ResetTransactionPinParam(
          email: _user.email,
          otp: otp.value,
          pin: newPin.value,
          confirmPin: confirmPin.value,
        ),
      );

      res.fold(
        (l) {
          emit(
            state.copyWith(
              status: ResetTransactionPinStatus.failure,
              message: l.message,
            ),
          );
        },
        (r) {
          state.copyWith(
            status: ResetTransactionPinStatus.success,
            message: 'Transaction PIN has been reset successfully.',
          );
          onSubmit.call();
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ResetTransactionPinStatus.failure,
          message: 'Failed to Change',
        ),
      );
    }
  }
}
