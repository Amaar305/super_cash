import 'package:app_client/app_client.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:token_repository/token_repository.dart';

class ApiErrorHandler {
  final AppCubit _appCubit;

  const ApiErrorHandler({required AppBloc appBloc, required AppCubit appCubit})
    : _appCubit = appCubit;

  Failure handleError(dynamic error) {
    if (error is Failure) {
      return error;
    }
    if (error is RefreshTokenException) {
      // _appBloc.add(UserLoggedOut());
      _appCubit.tokenExpired();
      final message =
          error.message.isNotEmpty ? error.message : 'Session Expired';
      return RefreshTokenFailure(message);
    }
    if (error is CacheException) {
      return CacheFailure(error.message);
    }
    if (error is FormatException) {
      return ServerFailure('Invalid JSON from server.');
    }

    if (error is ServerException) {
      return ServerFailure(error.message);
    }
    if (error is ApiException) {
      final message = error.message.isNotEmpty
          ? error.message
          : 'Something went wrong. Please try again.';
      return ServerFailure(message);
    }
    if (error is NetworkFailure || error is NetworkException) {
      final message = error is NetworkFailure
          ? error.message
          : (error as NetworkException).message;
      return NetworkFailure(
        message.isNotEmpty ? message : 'No internet connection.',
      );
    }
    return ServerFailure(error.toString());
  }
}
