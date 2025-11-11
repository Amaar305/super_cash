part of 'app_cubit.dart';

enum AppStatus2 {
  initial,
  authenticated,
  unauthenticated,
  onboarding,
  splash,
  welcome,
  enableBiometric,
  verifyAccount,
  createPin,
  tokenExpired,
  referralType,
}

class AppState extends Equatable {
  final AppStatus2 status;
  final AppUser? user;
  final bool showLogin;

  const AppState._({
    required this.status,
    required this.user,
    this.showLogin = true,
  });

  @override
  List<Object?> get props => [user, status, showLogin];

  factory AppState.initial() {
    return const AppState._(
      status: AppStatus2.initial,
      user: null,
      showLogin: true,
    );
  }
  factory AppState.authenticated(AppUser user) {
    return AppState._(status: AppStatus2.authenticated, user: user);
  }
  factory AppState.unauthenticated([bool showLoginScreen = true]) {
    return AppState._(
      status: AppStatus2.unauthenticated,
      user: null,
      showLogin: showLoginScreen,
    );
  }
  factory AppState.onboarding() {
    return const AppState._(status: AppStatus2.onboarding, user: null);
  }

  factory AppState.splash() {
    return const AppState._(status: AppStatus2.splash, user: null);
  }

  factory AppState.welcome() {
    return const AppState._(status: AppStatus2.welcome, user: null);
  }
  factory AppState.enableBiometric(AppUser user) {
    return AppState._(status: AppStatus2.enableBiometric, user: user);
  }
  factory AppState.verifyAccount(AppUser user) {
    return AppState._(status: AppStatus2.verifyAccount, user: user);
  }

  factory AppState.createPin() {
    return const AppState._(status: AppStatus2.createPin, user: null);
  }
  factory AppState.referralType() {
    return const AppState._(status: AppStatus2.referralType, user: null);
  }

  factory AppState.tokenExpired() {
    return const AppState._(status: AppStatus2.tokenExpired, user: null);
  }

  AppState copyWith({AppStatus2? status, AppUser? user}) {
    return AppState._(status: status ?? this.status, user: user ?? this.user);
  }
}
