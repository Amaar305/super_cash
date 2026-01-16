import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

part 'confirm_transaction_pin_state.dart';

class ConfirmTransactionPinCubit extends Cubit<ConfirmTransactionPinState> {
  final VerifyTransactionPinUseCase _verifyTransactionPinUseCase;
  ConfirmTransactionPinCubit({
    required VerifyTransactionPinUseCase verifyTransactionPinUseCase,
  }) : _verifyTransactionPinUseCase = verifyTransactionPinUseCase,
       super(ConfirmTransactionPinState.initial());

  void resetState() => emit(ConfirmTransactionPinState.initial());

  void onPinChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.pin;
    final shouldValidate = previousPinState.invalid;

    final newPinState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState = previousScreenState.copyWith(pin: newPinState);

    emit(newScreenState);
  }

  Future<void> onVerifyPin({void Function(ConfirmPin)? onVerified}) async {
    final pin = Otp.dirty(state.pin.value);

    final isFormValid = FormzValid([pin]).isFormValid;

    final newState = state.copyWith(
      pin: pin,
      status: isFormValid ? ConfirmTransactionPinStatus.loading : null,
    );

    if (!isFormValid || isClosed) return;

    emit(newState);

    try {
      final res = await _verifyTransactionPinUseCase(
        VerifyTransactionParam(pin: pin.value),
      );

      res.fold(
        (l) => emit(
          state.copyWith(
            status: ConfirmTransactionPinStatus.failure,
            message: l.message,
          ),
        ),
        (r) {
          emit(
            state.copyWith(
              status: ConfirmTransactionPinStatus.success,
              confirmPin: r,
            ),
          );

          onVerified?.call(r);
        },
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          status: ConfirmTransactionPinStatus.failure,
          message: 'Something went wrong.',
        ),
      );
    }
  }
}
