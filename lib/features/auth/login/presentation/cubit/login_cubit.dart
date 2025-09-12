import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

import '../../../../../app/bloc/app_bloc.dart';
import '../../domain/domain.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final LoginWithBiometricUseCase _biometricUseCase;
  final AppBloc _appBloc;

  LoginCubit({
    required LoginUseCase loginUseCase,
    required AppBloc appBloc,
    required LoginWithBiometricUseCase biometricUseCase,
    required bool hasBiometric,
  }) : _loginUseCase = loginUseCase,
       _appBloc = appBloc,
       _biometricUseCase = biometricUseCase,
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
    final previousPasswordState = previousScreenState.email;
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
    void Function(AppUser)? onSuccess,
    VoidCallback? onFallbackToPassword,
  }) async {
    final newState = state.copyWith(status: LoginStatus.loading);

    emit(newState);

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
        _appBloc.add(UserLoggedOut());
      },
      (token) {
        emit(state.copyWith(status: LoginStatus.success, user: token));
        onSuccess?.call(token);
      },
    );
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
    VoidCallback? onSuccess,
    void Function(AppUser)? onEnableBiometric,
  }) async {
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

    final res = await _loginUseCase(
      LoginParams(username: email.value, password: password.value),
    );

    if (isClosed) return;

    res.fold(
      (l) {
        emit(state.copyWith(message: l.message, status: LoginStatus.error));
        // _appBloc.add(UserLoggedOut());
        logI(l.message);
      },
      (token) {
        emit(state.copyWith(status: LoginStatus.success, user: token));
        if (token.transactionPin) {
          final enabled =
              serviceLocator<TokenRepository>().getBiometric() ?? false;
          if (enabled) {
            _appBloc.add(UserLoggedIn(token));
          } else {
            onEnableBiometric?.call(token);
          }
          return;
        }
        onSuccess?.call();
      },
    );
  }
}
