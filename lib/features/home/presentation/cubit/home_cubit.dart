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
  }) : _fetchAppSettingsUseCase = fetchAppSettingsUseCase,
       _fetchUserUseCase = fetchUserUseCase,
       _appCubit = appCubit,
       super(HomeState.initial());
  final FetchUserUseCase _fetchUserUseCase;
  final FetchAppSettingsUseCase _fetchAppSettingsUseCase;
  final AppCubit _appCubit;

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
    if (isClosed) return;
    if (state.user != AppUser.anonymous && !forceRefresh) {
      // Data already available and we're not forcing refresh
      return;
    }

    emit(state.copyWith(status: HomeStatus.loading));
    final res = await _fetchUserUseCase(NoParam());

    if (isClosed) return;

    res.fold(
      (l) =>
          emit(state.copyWith(status: HomeStatus.failure, message: l.message)),
      (r) {
        if (r.isSuspended) {
          emit(
            state.copyWith(
              user: r,
              status: HomeStatus.failure,
              message: 'You have been suspended from this app.',
            ),
          );
          _appCubit.logout();
          return;
        }
        emit(state.copyWith(user: r, status: HomeStatus.success));

        _appCubit.updateUser(r);
      },
    );
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
  String get id => "Home_${state.user.id}";

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    return HomeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) => state.toJson();
}
