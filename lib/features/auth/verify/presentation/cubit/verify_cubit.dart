import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../verify.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  final OtpUseCase _otpUseCase;
  VerifyCubit({required OtpUseCase otpUseCase})
      : _otpUseCase = otpUseCase,
        super(VerifyState.initial());

  void resetState() => emit(VerifyState.initial());

  void onOtpChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.otp;
    final shouldValidate = previousPinState.invalid;

    final otpState = shouldValidate ? Otp2.dirty(value) : Otp2.dirty(value);

    final newScreenState = previousScreenState.copyWith(otp: otpState);

    emit(newScreenState);
  }

  void onSubmit(VoidCallback? onSuccess) async {
    final otp = Otp2.dirty(state.otp.value);
    final isFormValid = FormzValid([otp]).isFormValid;
    final newState = state.copyWith(
      otp: otp,
      status: isFormValid ? VerifyStatus.loading : null,
    );

    emit(newState);
    if (!isFormValid) return;

    try {
      final res = await _otpUseCase(OtpParam(otp: otp.value));
      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(
            status: VerifyStatus.failure,
            message: l.message,
          ),
        ),
        (r) {
          emit(
            state.copyWith(status: VerifyStatus.success, response: r),
          );
          onSuccess?.call();
        },
      );
    } catch (e, er) {
      logE(e, error: e, stackTrace: er);
    }
  }
}
