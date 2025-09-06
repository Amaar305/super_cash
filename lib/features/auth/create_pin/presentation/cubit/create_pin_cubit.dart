import 'package:super_cash/features/auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

part 'create_pin_state.dart';

class CreatePinCubit extends Cubit<CreatePinState> {
  CreatePinCubit({required CreatePinUseCase createPinUseCase})
    : _createPinUseCase = createPinUseCase,
      super(CreatePinState.inital());
  final CreatePinUseCase _createPinUseCase;

  void resetState() => emit(CreatePinState.inital());

  void changePinVisibility() => emit(state.copyWith(showPin: !state.showPin));

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

    // if (didMatched) {
    //   emit(state.copyWith(confirmPinMessage: 'Pin does not match'));
    // }
    final didMatched = value == previousScreenState.newPin.value;

    final newPinState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState = previousScreenState.copyWith(
      confirmPin: newPinState,
      confirmPinMessage: !didMatched ? 'Pin does not match' : '',
    );

    emit(newScreenState);
  }

  void onSubmit([VoidCallback? onSuccess]) async {
    final newPin = Otp.dirty(state.newPin.value);
    final confirmPin = Otp.dirty(state.confirmPin.value);
    final didMatched = newPin.value == confirmPin.value;

    final isFormValid =
        FormzValid([newPin, confirmPin]).isFormValid && didMatched;

    final newState = state.copyWith(
      newPin: newPin,
      confirmPin: confirmPin,
      status: isFormValid ? CreatePinStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    final res = await _createPinUseCase(CreatePinParam(pin: newPin.value));

    if (isClosed) return;

    res.fold(
      (l) => emit(
        state.copyWith(status: CreatePinStatus.failure, message: l.message),
      ),
      (r) {
        emit(state.copyWith(status: CreatePinStatus.success, response: r));
        onSuccess?.call();
      },
    );
  }
}
