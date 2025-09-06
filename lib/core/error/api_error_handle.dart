import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:token_repository/token_repository.dart';

class ApiErrorHandler {
  final AppBloc _appBloc;

  ApiErrorHandler({required AppBloc appBloc}) : _appBloc = appBloc;

  Failure handleError(dynamic error) {
    if (error is RefreshTokenException) {
      _appBloc.add(UserLoggedOut());
      return RefreshTokenFailure('Session Expired');
    }
    if (error is NetworkFailure) {
      return NetworkFailure('No internet connection.');
    }
    return ServerFailure(error.toString());
  }
}
