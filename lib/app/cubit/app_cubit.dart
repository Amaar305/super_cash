import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/device/device.dart';
import 'package:super_cash/features/auth/login/login.dart';
import 'package:token_repository/token_repository.dart';

part 'app_state.dart';

const String _onboardingKey = 'onboarded';

class AppCubit extends Cubit<AppState> {
  final TokenRepository _tokenRepository;
  final LoginLocalDataSource _loginLocalDataSource;
  final SharedPreferences _preferences;
  AppCubit({
    required final TokenRepository tokenRepository,
    required LoginLocalDataSource loginLocalDataSource,
    required SharedPreferences preferences,
  }) : _loginLocalDataSource = loginLocalDataSource,
       _tokenRepository = tokenRepository,
       _preferences = preferences,
       super(AppState.initial());

  Future<void> appStarted() async {
    try {
      final completedOnboarding = _preferences.getBool(_onboardingKey) ?? false;
      final tokensExist = await _tokenRepository.hasToken();
      final user = _loginLocalDataSource.getUser();

      if (!completedOnboarding && !tokensExist) {
        emit(AppState.onboarding());
        return;
      }

      if (!tokensExist) {
        emit(AppState.welcome());
        return;
      }

      if (user == null || user.isAnonymous) {
        emit(AppState.unauthenticated());
        return;
      }
      emit(AppState.unauthenticated());

      // _emitUserState(user);
    } catch (_) {
      await _tokenRepository.clearTokens();
      emit(AppState.welcome());
    }
  }

  void userStarted(bool showLoginScreen) {
    emit(AppState.unauthenticated(showLoginScreen));
  }

  Future<void> userLoggedIn(AppUser user) async {
    try {
      unawaited(serviceLocator<DeviceRegistrar>().register(withAuth: true));
      _emitUserState(user);
    } catch (_) {
      emit(AppState.unauthenticated());
    }
  }

  Future<void> completeOnboarding() async {
    await _preferences.setBool(_onboardingKey, true);
    emit(AppState.welcome());
  }

  Future<void> updateUser(AppUser user) async {
    _emitUserState(user);
  }

  Future<void> tokenExpired() async {
    await _tokenRepository.clearTokens();
    await _loginLocalDataSource.clearUser();
    emit(AppState.tokenExpired());
  }

  Future<void> logout() async {
    await _tokenRepository.clearTokens();
    await _loginLocalDataSource.clearUser();
    await _preferences.remove(_onboardingKey);
    emit(AppState.welcome());
  }

  void enableBiometric(AppUser user) {
    emit(AppState.enableBiometric(user));
  }

  Future<void> _emitUserState(AppUser user) async {
    try {
      await _loginLocalDataSource.clearUser();
      await _loginLocalDataSource.persistUser(user);

      // if (!user.isVerified) {
      //   emit(AppState.verifyAccount(user));
      //   return;
      // }

      if (!user.transactionPin) {
        emit(AppState.createPin());
        return;
      }

      if (user.isAnonymous) {
        emit(AppState.unauthenticated());
        return;
      }

      emit(AppState.authenticated(user));
    } catch (_) {
      emit(AppState.unauthenticated());
    }
  }

  void createPin(AppUser user) {
    emit(state.copyWith(status: AppStatus2.createPin, user: user));
  }

  void verifyAccount(AppUser user) {
    emit(state.copyWith(status: AppStatus2.verifyAccount, user: user));
  }

  void referralType() {
    emit(AppState.referralType());
  }
}
