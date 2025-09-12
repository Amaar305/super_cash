part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AppEvent {
  const AppStarted();
}

class UserLoggedIn extends AppEvent {
  final AppUser user;

  const UserLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

class UserUpdate extends AppEvent {
  final AppUser user;

  const UserUpdate(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AppEvent {
  const UserLoggedOut();
}
