import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

import '../../domain/domain.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final LoginWithBiometricUseCase _biometricUseCase;
  final DetermineLoginFlowUseCase _determineLoginFlowUseCase;
  final AppCubit _appBloc;

  LoginCubit({
    required LoginUseCase loginUseCase,
    required AppCubit appBloc,
    required LoginWithBiometricUseCase biometricUseCase,
    required DetermineLoginFlowUseCase determineLoginFlowUseCase,
    required bool hasBiometric,
  }) : _loginUseCase = loginUseCase,
       _appBloc = appBloc,
       _biometricUseCase = biometricUseCase,
       _determineLoginFlowUseCase = determineLoginFlowUseCase,
       super(LoginState.initial());

  Future<void> initialize() async {
    final capability = false;
    final enabled = serviceLocator<TokenRepository>().getBiometric() ?? false;

    emit(
      state.copyWith(
        hasBiometric: enabled,
        hasBiometricCapability: capability,
        isPasswordLogin:
            state.shouldDefaultToBiometric, // Auto-select if available
      ),
    );
  }

  void changePasswordVisibility() =>
      emit(state.copyWith(showPassword: !state.showPassword));

  /// Emits initial state of login screen.
  void resetState({required bool hasBiometric}) => emit(LoginState.initial());

  void onRememberMeChecked(bool rememberMe) {
    if (state.rememberMe == rememberMe) return;

    emit(state.copyWith(rememberMe: rememberMe));
  }

  // Pure tab toggles
  void switchToPasswordLogin() => emit(state.copyWith(isPasswordLogin: true));
  void switchToBiometricLogin() {
    emit(state.copyWith(isPasswordLogin: false));
  }

  void onEmailChanged(String value) {
    final previouScreenState = state;

    final previousEmailState = previouScreenState.email;
    final shouldValidate = previousEmailState.invalid;

    final newEmailState = shouldValidate
        ? Email.dirty(value)
        : Email.pure(value);

    final newScreenState = state.copyWith(email: newEmailState);

    emit(newScreenState);
  }

  void onEmailUnfocused() {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.email;
    final previousEmailValue = previousEmailState.value;

    final newEmailState = Email.dirty(previousEmailValue);

    final newScreenState = previousScreenState.copyWith(email: newEmailState);

    emit(newScreenState);
  }

  void onPasswordChanged(String value) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.invalid;

    final newPasswordValue = shouldValidate
        ? Password.dirty(value)
        : Password.pure(value);

    final newScreenState = previousScreenState.copyWith(
      password: newPasswordValue,
    );
    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.dirty(previousPasswordValue);

    final newPasswordScreen = previousScreenState.copyWith(
      password: newPasswordState,
    );

    emit(newPasswordScreen);
  }

  void onLoginWithBiometric({
    void Function(AppUser user)? onSuccess,
    VoidCallback? onFallbackToPassword,
  }) async {
    if (isClosed) return;

    emit(state.copyWith(status: LoginStatus.loading));

    final res = await _biometricUseCase(NoParam());

    if (isClosed) return;

    res.fold(
      (l) {
        emit(
          state.copyWith(
            message: l.message,
            status: LoginStatus.error,
            // isPasswordLogin: true,
          ),
        );
        onFallbackToPassword?.call();
        // _appBloc.logout();
      },
      (user) {
        emit(state.copyWith(status: LoginStatus.success, user: user));
        onSuccess?.call(user);
      },
    );
  }

  void onBiometricFailure(String message) {
    emit(state.copyWith(message: message, status: LoginStatus.error));
  }

  // Add this method to your LoginCubit
  void biometricRegistrationCompleted() {
    emit(
      state.copyWith(
        hasBiometric: true,
        isPasswordLogin: false, // Switch to biometric tab after registration
      ),
    );
  }

  void submit({
    void Function(AppUser user)? onSuccess,
    void Function(AppUser user)? onEnableBiometric,
  }) async {
    // Validate the raw form values before hitting the network.
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    final isFormValid = FormzValid([email, password]).isFormValid;

    final newState = state.copyWith(
      email: email,
      password: password,
      status: isFormValid ? LoginStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    // Run the login use case against the API.
    final res = await _loginUseCase(
      LoginParams(username: email.value, password: password.value),
    );

    if (isClosed) return;

    await res.fold(
      (l) {
        if (isClosed) return;

        emit(state.copyWith(message: l.message, status: LoginStatus.error));
        // _appBloc.add(UserLoggedOut());
      },
      (user) async {
        if (isClosed) return;
        emit(state.copyWith(status: LoginStatus.success, user: user));

        // Decide the next screen or action to trigger after login succeeds.
        final decisionEither = await _determineLoginFlowUseCase(user);
        final decision = decisionEither.fold((l) => null, (r) => r);

        if (decision == null) {
          // If determining the flow failed, fallback to generic success behavior.
          onSuccess?.call(user);
          return;
        }

        switch (decision.action) {
          case LoginFlowAction.requestTransactionPin:
          case LoginFlowAction.requestVerification:
            onSuccess?.call(user);
            return;
          case LoginFlowAction.authenticateUser:
            // _appBloc.add(UserLoggedIn(user));
            _appBloc.userLoggedIn(user);
            return;
          case LoginFlowAction.promptBiometricEnrollment:
            onEnableBiometric?.call(user);
            return;
        }
      },
    );
  }
}
