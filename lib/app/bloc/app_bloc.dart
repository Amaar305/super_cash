import 'dart:async';

import 'package:super_cash/app/init/init.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

import '../../features/auth/login/login.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final TokenRepository _tokenRepository;

  AppBloc({
    required TokenRepository tokenRepository,
    required LoginRepository userRepository,
  }) : _tokenRepository = tokenRepository,
       super(const AppState.unknown()) {
    on<AppStarted>(_onAppStarted);
    on<UserLoggedIn>(_onUserLoggedIn);
    on<UserLoggedOut>(_onUserLoggedOut);
    on<UserUpdate>(_onUserUpdate);

    // Check auth status when bloc is created
    // add(const AppStarted());
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    try {
      final tokensExist = await _tokenRepository.hasToken();

      if (tokensExist) {
        // final res = await _userRepository.fetchUserDetails();
        // res.fold(
        //   (l) {
        //     emit(const AppState.unauthenticated());
        //     openSnackbar(SnackbarMessage.error(title: l.message),
        //         clearIfQueue: true);
        //   },
        //   (user) {
        //     emit(AppState.authenticated(user));
        //   },
        // );
        emit(AppState.resumed());
      } else {
        emit(const AppState.unauthenticated());
      }
      // emit(AppState.resumed());
    } catch (_) {
      await _tokenRepository.clearTokens();
      // await _userRepository.clearUser();
      emit(const AppState.unauthenticated());
    }
  }

  Future<void> _onUserLoggedIn(
    UserLoggedIn event,
    Emitter<AppState> emit,
  ) async {
    await serviceLocator<LoginLocalDataSource>().persistUser(event.user);

    emit(AppState.authenticated(event.user));
  }

  Future<void> _onUserUpdate(UserUpdate event, Emitter<AppState> emit) async {
    // await _userRepository.persistUser(event.user);

    emit(AppState.updated(event.user));
  }

  Future<void> _onUserLoggedOut(
    UserLoggedOut event,
    Emitter<AppState> emit,
  ) async {
    await _tokenRepository.clearTokens();
    // await _userRepository.clearUser();
    await serviceLocator<LoginLocalDataSource>().clearUser();
    emit(const AppState.unauthenticated());
  }
}
