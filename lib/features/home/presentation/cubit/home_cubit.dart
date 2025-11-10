import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared/shared.dart';

import '../../home.dart';

part 'home_state.dart';
part 'home_cubit.g.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit(this.fetchUserUseCase, this.appBloc) : super(HomeState.initial());
  final FetchUserUseCase fetchUserUseCase;
  final AppBloc appBloc;

  void showBalance() => emit(state.copyWith(showBalance: !state.showBalance));

  void onLogout() {
    try {
      appBloc.add(UserLoggedOut());
      emit(state.copyWith(user: null, status: HomeStatus.initial));
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
    final res = await fetchUserUseCase(NoParam());

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
          appBloc.add(UserLoggedOut());
          return;
        }
        emit(state.copyWith(user: r, status: HomeStatus.success));
        logI(r.email);
        appBloc.add(UserUpdate(r));
      },
    );
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
