import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:token_repository/token_repository.dart';

class ApiErrorHandler {
  final AppCubit _appCubit;

  const ApiErrorHandler({required AppBloc appBloc, required AppCubit appCubit})
    : _appCubit = appCubit;

  Failure handleError(dynamic error) {
    if (error is RefreshTokenException) {
      // _appBloc.add(UserLoggedOut());
      _appCubit.tokenExpired();
      return RefreshTokenFailure('Session Expired');
    }
    if (error is NetworkFailure) {
      return NetworkFailure('No internet connection.');
    }
    return ServerFailure(error.toString());
  }
}
