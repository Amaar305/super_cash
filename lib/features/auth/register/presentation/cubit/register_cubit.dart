import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';

import '../../register.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required RegisterUseCase registerUseCase})
    : _registerUseCase = registerUseCase,
      super(RegisterState.initial());

  final RegisterUseCase _registerUseCase;

  /// Changes password visibility, making it visible or not.
  void changePasswordVisibility({bool confirmPass = false}) {
    if (confirmPass) {
      emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
    } else {
      emit(state.copyWith(showPassword: !state.showPassword));
    }
  }

  void changeTermsCondition() => emit(
    state.copyWith(agreedToTermsAndCondition: !state.agreedToTermsAndCondition),
  );

  void changeType(bool basicSignup) {
    if (state.basicSignup == basicSignup) return;

    emit(state.copyWith(basicSignup: basicSignup));
  }

  /// Emits initial state of login screen.
  void resetState() => emit(const RegisterState.initial());

  /// Email value was changed, triggering new changes in state.
  void onEmailChanged(String newValue) {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.email;
    final shouldValidate = previousEmailState.invalid;
    final newEmailState = shouldValidate
        ? Email.dirty(newValue)
        : Email.pure(newValue);

    final newScreenState = state.copyWith(email: newEmailState);

    emit(newScreenState);
  }

  /// Email field was unfocused, here is checking if previous state with email
  /// was valid, in order to indicate it in state after unfocus.
  void onEmailUnfocused() {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.email;
    final previousEmailValue = previousEmailState.value;

    final newEmailState = Email.dirty(previousEmailValue);
    final newScreenState = previousScreenState.copyWith(email: newEmailState);
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
        ? Password.dirty(newValue)
        : Password.pure(newValue);

    final confirmPasswordError = _confirmPasswordError(
      password: newPasswordState.value,
      confirmPassword: previousScreenState.confirmPassword.value,
    );

    final newScreenState = state.copyWith(
      password: newPasswordState,
      confirmPasswordError: confirmPasswordError,
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.dirty(previousPasswordValue);
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
    final newPasswordState = shouldValidate
        ? Password.dirty(newValue)
        : Password.pure(newValue);

    final confirmPasswordError = _confirmPasswordError(
      password: previousScreenState.password.value,
      confirmPassword: newPasswordState.value,
    );

    final newScreenState = state.copyWith(
      confirmPassword: newPasswordState,
      confirmPasswordError: confirmPasswordError,
    );

    emit(newScreenState);
  }

  void onConfirmPasswordUnfocused() {
    final previousScreenState = state;
    final previousConfirmPasswordState = previousScreenState.confirmPassword;
    final previousPasswordValue = previousConfirmPasswordState.value;

    final newPasswordState = Password.dirty(previousPasswordValue);
    final newScreenState = previousScreenState.copyWith(
      confirmPassword: newPasswordState,
    );
    emit(newScreenState);
  }

  /// [FirstName] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [FirstName] and emmiting new [FirstName]
  /// validation state.
  void onFirstNameChanged(String newValue) {
    final previousScreenState = state;
    final previousFirstNameState = previousScreenState.firstName;
    final shouldValidate = previousFirstNameState.invalid;
    final newFullNameState = shouldValidate
        ? FirstName.dirty(newValue)
        : FirstName.pure(newValue);

    final newScreenState = state.copyWith(firstName: newFullNameState);

    emit(newScreenState);
  }

  /// [FirstName] field was unfocused, here is checking if previous state with
  /// [FirstName] was valid, in order to indicate it in state after unfocus.
  void onFirstNameUnfocused() {
    final previousScreenState = state;
    final previousFirstNameState = previousScreenState.firstName;
    final previousFullNameValue = previousFirstNameState.value;

    final newFullNameState = FirstName.dirty(previousFullNameValue);
    final newScreenState = previousScreenState.copyWith(
      firstName: newFullNameState,
    );
    emit(newScreenState);
  }

  /// [LastName] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [LastName] and emmiting new [LastName]
  /// validation state.
  void onLastNameChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.lastName;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? LastName.dirty(newValue)
        : LastName.pure(newValue);

    final newScreenState = state.copyWith(lastName: newSurnameState);

    emit(newScreenState);
  }

  void onLastNameUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.lastName;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = LastName.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      lastName: newUsernameState,
    );
    emit(newScreenState);
  }

  /// [Phone] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [LastName] and emmiting new [LastName]
  /// validation state.
  void onPhoneChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.phone;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? Phone.dirty(newValue)
        : Phone.pure(newValue);

    final newScreenState = state.copyWith(phone: newSurnameState);

    emit(newScreenState);
  }

  void onPhoneUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.phone;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = Phone.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      phone: newUsernameState,
    );
    emit(newScreenState);
  }

  /// [Phone] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [LastName] and emmiting new [LastName]
  /// validation state.
  void onReferralChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.referral;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? Referral.dirty(newValue)
        : Referral.pure(newValue);

    final newScreenState = state.copyWith(referral: newSurnameState);

    emit(newScreenState);
  }

  void onReferralUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.referral;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = Referral.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      referral: newUsernameState,
    );
    emit(newScreenState);
  }

  void submit(void Function(AppUser userr)? onSuccess) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final password2 = Password.dirty(state.confirmPassword.value);
    final firstName = FirstName.dirty(state.firstName.value);
    final lastName = LastName.dirty(state.lastName.value);
    final phone = Phone.dirty(state.phone.value);
    final referral = Referral.dirty(state.referral.value);
    final isFormValid = FormzValid([
      email,
      password,
      password2,
      firstName,
      lastName,
      phone,
      referral,
      // referral,
    ]).isFormValid;
    final passwordsMatch = password.value == password2.value;

    final newState = state.copyWith(
      email: email,
      password: password,
      confirmPassword: password2,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      confirmPasswordError: passwordsMatch ? '' : 'Password does not match',
      status: isFormValid && passwordsMatch ? RegisterStatus.inProgress : null,
      referral: referral,
    );

    emit(newState);

    if (!isFormValid || !passwordsMatch) return;

    final res = await _registerUseCase(
      RegisterParam(
        email: email.value,
        phone: phone.value,
        firstName: firstName.value,
        lastName: lastName.value,
        password: password.value,
        confirmPassword: password2.value,

        referral: referral.value.isEmpty ? null : referral.value,
      ),
    );
    if (isClosed) return;
    res.fold(
      (l) => emit(
        state.copyWith(status: RegisterStatus.error, errorMessage: l.message),
      ),
      (r) {
        emit(state.copyWith(status: RegisterStatus.success, user: r));
        onSuccess?.call(r);
      },
    );
  }

  String _confirmPasswordError({
    required String password,
    required String confirmPassword,
  }) {
    if (confirmPassword.isEmpty) return '';
    return password == confirmPassword ? '' : 'Password does not match';
  }
}
