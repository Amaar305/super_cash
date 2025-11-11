import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../verify.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  final OtpUseCase _otpUseCase;
  final RequestVerifyOtpUseCase _requestVerifyOtpUseCase;
  final String _email;
  VerifyCubit({
    required OtpUseCase otpUseCase,
    required String email,
    required RequestVerifyOtpUseCase requestVerifyOtpUseCase,
  }) : _otpUseCase = otpUseCase,
       _requestVerifyOtpUseCase = requestVerifyOtpUseCase,
       _email = email,
       super(VerifyState.initial());

  void resetState() => emit(VerifyState.initial());

  void onOtpChanged(String value) {
    final previousScreenState = state;
    final previousPinState = previousScreenState.otp;
    final shouldValidate = previousPinState.invalid;

    final otpState = shouldValidate ? Otp.dirty(value) : Otp.dirty(value);

    final newScreenState = previousScreenState.copyWith(otp: otpState);

    emit(newScreenState);
  }

  Future<void> requestOtp() async {
    if (isClosed) return;

    emit(state.copyWith(status: VerifyStatus.loading));

    try {
      final res = await _requestVerifyOtpUseCase(
        RequestVerifyOtpParams(email: _email),
      );
      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(status: VerifyStatus.failure, message: l.message),
        ),
        (_) => emit(state.copyWith(status: VerifyStatus.otpRequested)),
      );
    } catch (error, stackTrace) {
      logE('Failed to request otp', error: error, stackTrace: stackTrace);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: VerifyStatus.failure,
          message: 'Failed to request OTP. Please try again.',
        ),
      );
    }
  }

  void onSubmit(void Function(AppUser user) onSuccess) async {
    final otp = Otp.dirty(state.otp.value);
    final isFormValid = FormzValid([otp]).isFormValid;
    final newState = state.copyWith(
      otp: otp,
      status: isFormValid ? VerifyStatus.loading : null,
    );

    emit(newState);
    if (!isFormValid) return;

    try {
      final res = await _otpUseCase(OtpParam(otp: otp.value, email: _email));
      if (isClosed) return;

      res.fold(
        (l) => emit(
          state.copyWith(status: VerifyStatus.failure, message: l.message),
        ),
        (r) {
          emit(state.copyWith(status: VerifyStatus.success,));
          onSuccess.call(r);
        },
      );
    } catch (e, er) {
      logE(e, error: e, stackTrace: er);
    }
  }
}
