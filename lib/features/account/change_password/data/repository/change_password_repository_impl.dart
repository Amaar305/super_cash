import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repository/change_password_repository.dart';
import '../datasource/change_password_remote_data_source.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordRemoteDataSource changePasswordRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  const ChangePasswordRepositoryImpl({
    required this.changePasswordRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final result = await changePasswordRemoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
}
