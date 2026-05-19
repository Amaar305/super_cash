import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';

import '../../home.dart';

part 'home_state.dart';
part 'home_cubit.g.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit({
    required FetchAppSettingsUseCase fetchAppSettingsUseCase,
    required FetchUserUseCase fetchUserUseCase,
    required AppCubit appCubit,
    required CreatePalmPayAccountUseCase createPalmPayAccountUseCase,
  }) : _fetchAppSettingsUseCase = fetchAppSettingsUseCase,
       _fetchUserUseCase = fetchUserUseCase,
       _appCubit = appCubit,
       _createPalmPayAccountUseCase = createPalmPayAccountUseCase,
       super(HomeState.initial());
  final FetchUserUseCase _fetchUserUseCase;
  final FetchAppSettingsUseCase _fetchAppSettingsUseCase;
  final AppCubit _appCubit;
  final CreatePalmPayAccountUseCase _createPalmPayAccountUseCase;

  void showBalance() => emit(state.copyWith(showBalance: !state.showBalance));

  void onLogout() {
    try {
      _appCubit.logout();
      emit(HomeState.initial());
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: HomeStatus.failure));
    }
  }

  Future<void> onRefresh({bool forceRefresh = false}) async {
    if (_shouldSkipRefresh(forceRefresh)) return;

    emit(state.copyWith(status: HomeStatus.loading));
    final res = await _fetchUserUseCase(NoParam());

    if (isClosed) return;

    await res.fold<Future<void>>(
      (failure) async => _emitFailure(failure.message),
      _handleFetchedUser,
    );
  }

  bool _shouldSkipRefresh(bool forceRefresh) {
    if (isClosed) return true;
    return state.user != AppUser.anonymous && !forceRefresh;
  }

  Future<void> _handleFetchedUser(AppUser user) async {
    if (_handleSuspendedUser(user)) return;

    final updatedUser = await _ensureUserHasAccount(user);
    if (isClosed) return;

    await _appCubit.updateUser(updatedUser);
  }

  bool _handleSuspendedUser(AppUser user) {
    if (!user.isSuspended) return false;

    emit(
      state.copyWith(
        user: user,
        status: HomeStatus.failure,
        message: 'You have been suspended from this app.',
      ),
    );
    _appCubit.logout();
    return true;
  }

  Future<AppUser> _ensureUserHasAccount(AppUser user) async {
    _emitUserLoaded(user);
    if (user.accounts.isNotEmpty) return user;

    final account = await _createPalmPayAccount();
    if (account == null) return user;

    final updatedUser = user.copyWith(accounts: [account]);
    _emitUserLoaded(updatedUser);
    return updatedUser;
  }

  Future<Account?> _createPalmPayAccount() async {
    final accountResult = await _createPalmPayAccountUseCase(NoParam());
    if (isClosed) return null;

    return accountResult.fold((failure) {
      _emitFailure(failure.message);
      return null;
    }, (result) => result.account);
  }

  void _emitUserLoaded(AppUser user) {
    if (isClosed) return;
    emit(state.copyWith(user: user, status: HomeStatus.success));
  }

  void _emitFailure(String message) {
    if (isClosed) return;
    emit(state.copyWith(status: HomeStatus.failure, message: message));
  }

  Future<void> fetchAppSettings() async {
    if (isClosed) return;
    // emit(state.copyWith(status: HomeStatus.loading, message: ''));
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final params = FetchAppSettingsParams(
        platform: _currentPlatform(),
        version: packageInfo.version,
        versionCode: packageInfo.buildNumber,
      );
      final result = await _fetchAppSettingsUseCase(params);
      result.fold(
        (failure) => emit(
          state.copyWith(status: HomeStatus.failure, message: failure.message),
        ),
        (settings) => emit(
          state.copyWith(
            status: HomeStatus.success,
            message: '',
            homeSettings: settings,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, message: e.toString()));
    }
  }

  String _currentPlatform() {
    if (kIsWeb) return 'web';
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.macOS:
        return 'macos';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.linux:
        return 'linux';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
    }
  }

  @override
  String get id => "Home_v2";

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    return HomeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) => state.toJson();
}
