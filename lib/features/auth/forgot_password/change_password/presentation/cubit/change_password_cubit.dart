import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../../forgot_password.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  ChangePasswordCubit({
    required ChangePasswordUseCase changePasswordUseCase,
  })  : _changePasswordUseCase = changePasswordUseCase,
        super(ChangePasswordState.initial());

  /// Changes password visibility, making it visible or not.
  void changePasswordVisibility({bool confirmPass = false}) {
    if (confirmPass) {
      emit(
        state.copyWith(showConfirmPassword: !state.showConfirmPassword),
      );
    } else {
      emit(
        state.copyWith(showPassword: !state.showPassword),
      );
    }
  }

  /// Emits initial state of login screen.
  void resetState() => emit(const ChangePasswordState.initial());

  /// OTP field was unfocused, here is checking if previous state with OTP
  /// was valid, in order to indicate it in state after unfocus.
  void onOtpUnfocused() {
    final previousScreenState = state;
    final previousOtpState = previousScreenState.otp;
    final previousOtpValue = previousOtpState.value;

    final newOtpState = Otp2.dirty(
      previousOtpValue,
    );
    final newScreenState = previousScreenState.copyWith(
      otp: newOtpState,
    );
    emit(newScreenState);
  }

  /// OTP value was changed, triggering new changes in state.
  void onOtpChanged(String newValue) {
    final previousScreenState = state;
    final previousOtpState = previousScreenState.otp;
    final shouldValidate = previousOtpState.invalid;
    final newOtpState = shouldValidate
        ? Otp2.dirty(
            newValue,
          )
        : Otp2.pure(
            newValue,
          );

    final newScreenState = state.copyWith(
      otp: newOtpState,
    );

    emit(newScreenState);
  }

  /// Password value was changed, triggering new changes in state.
  /// Checking whether or not value is valid in [Password] and emmiting new
  /// [Password] validation state.
  void onPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.invalid;
    final newPasswordState = shouldValidate
        ? Password.dirty(
            newValue,
          )
        : Password.pure(
            newValue,
          );

    final newScreenState = state.copyWith(
      password: newPasswordState,
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.dirty(
      previousPasswordValue,
    );
    final newScreenState = previousScreenState.copyWith(
      password: newPasswordState,
    );
    emit(newScreenState);
  }

  /// Password value was changed, triggering new changes in state.
  /// Checking whether or not value is valid in [Password] and emmiting new
  /// [Password] validation state.
  void onConfirmPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousConfirmPasswordState = previousScreenState.confirmPassword;
    final shouldValidate = previousConfirmPasswordState.invalid;
    final didMatched = newValue == previousScreenState.password.value;

    final newPasswordState = shouldValidate
        ? Password.dirty(
            newValue,
          )
        : Password.pure(
            newValue,
          );

    final newScreenState = state.copyWith(
      confirmPassword: newPasswordState,
      confirmPasswordError: !didMatched ? 'Password does not match' : null,
    );

    emit(newScreenState);
  }

  void onConfirmPasswordUnfocused() {
    final previousScreenState = state;
    final previousConfirmPasswordState = previousScreenState.confirmPassword;
    final previousPasswordValue = previousConfirmPasswordState.value;

    final newPasswordState = Password.dirty(
      previousPasswordValue,
    );
    final newScreenState = previousScreenState.copyWith(
      confirmPassword: newPasswordState,
    );
    emit(newScreenState);
  }




  void submit({VoidCallback? onSuccess, required String email}) async {
    final password = Password.dirty(state.password.value);
    final password2 = Password.dirty(state.confirmPassword.value);
    final otp = Otp2.dirty(state.otp.value);
    final didMatched = password.value == password2.value;

    final isFormValid =
        FormzValid([password, password2, otp]).isFormValid && didMatched;

    final newState = state.copyWith(
      password: password,
      confirmPassword: password2,
      otp: otp,
      status: isFormValid ? ChangePasswordStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    final res = await _changePasswordUseCase(
      ChangePasswordParams(
        email: email,
        otp: otp.value,
        password: password.value,
        confirmPassword: password2.value,
      ),
    );

    if (isClosed) return;

    res.fold(
      (l) => emit(state.copyWith(
          status: ChangePasswordStatus.error, message: l.message)),
      (r) {
        emit(state.copyWith(
          status: ChangePasswordStatus.success,
          response: r,
        ));
        onSuccess?.call();
      },
    );

    // try {
    //   await Future.delayed(Duration(seconds: 4));
    //   emit(state.copyWith(status: ChangePasswordStatus.success));
    //   if (isClosed) return;

    //   onSuccess?.call();
    // } catch (error, stackTrace) {
    //   _errorFormatter(error, stackTrace);
    // }
  }


}
