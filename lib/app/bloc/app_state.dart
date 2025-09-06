part of 'app_bloc.dart';

enum AppStatus {
  unknown,
  authenticated,
  unauthenticated,
  updated,
  resumed,
}

class AppState extends Equatable {
  final AppStatus status;
  final AppUser user;

  const AppState._({
    required this.status,
    this.user = AppUser.anonymous,
  });

  const AppState.unknown() : this._(status: AppStatus.unknown);
  const AppState.resumed() : this._(status: AppStatus.resumed);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.authenticated(AppUser user)
      : this._(status: AppStatus.authenticated, user: user);
  const AppState.updated(AppUser user)
      : this._(status: AppStatus.updated, user: user);

  @override
  List<Object?> get props => [status, user];

  AppState copyWith({
    AppStatus? status,
    AppUser? user,
  }) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
