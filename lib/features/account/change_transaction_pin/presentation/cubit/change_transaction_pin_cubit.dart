import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../../manage_transaction_pin/domain/usecases/update_transaction_pin_use_case.dart';

part 'change_transaction_pin_state.dart';

class ChangeTransactionPinCubit extends Cubit<ChangeTransactionPinState> {
  final UpdateTransactionPinUseCase _updateTransactionPinUseCase;
  ChangeTransactionPinCubit({
    required UpdateTransactionPinUseCase updateTransactionPinUseCase,
  }) : _updateTransactionPinUseCase = updateTransactionPinUseCase,
       super(ChangeTransactionPinState.initial());

  void onCurrentPinChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.currentPin;
    final shouldValidate = previousPinState.invalid;

    final newPinState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState = previousScreenState.copyWith(
      currentPin: newPinState,
    );

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



  Future<void> submit() async {
    final currentPin = Otp.dirty(state.currentPin.value);
    final newPin = Otp.dirty(state.newPin.value);
    final confirmPin = Otp.dirty(state.confirmPin.value);
    final didMatched = newPin.value == confirmPin.value;

    final isFormValid =
        FormzValid([currentPin, newPin, confirmPin]).isFormValid && didMatched;

    final newState = state.copyWith(
      currentPin: currentPin,
      newPin: newPin,
      confirmPin: confirmPin,
      status: isFormValid ? ChangeTransactionPinStatus.loading : null,
    );

    emit(newState);
    if (!isFormValid || isClosed) return;

    try {
      final res = await _updateTransactionPinUseCase(
        UpdateTransactionPinParams(
          currentPin: currentPin.value,
          newPin: newPin.value,
          confirmPin: confirmPin.value,
        ),
      );

      res.fold(
        (failure) {
          emit(
            state.copyWith(
              message: failure.message,
              status: ChangeTransactionPinStatus.failure,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              message: success,
              status: ChangeTransactionPinStatus.success,
            ),
          );
        },
      );
    } catch (error, stackTrace) {
      logE('Failed to change transaction pin $error', stackTrace: stackTrace);

      emit(
        state.copyWith(
          message: 'Failed to change transaction pin',
          status: ChangeTransactionPinStatus.failure,
        ),
      );
    }
  }
}
