
import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/account/account_deletion/account_deletion.dart';

class AccountDeletionRepositoryImpl implements AccountDeletionRepository {
  final AccountDeletionRemoteDataSource _accountDeletionRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

 const AccountDeletionRepositoryImpl({required AccountDeletionRemoteDataSource accountDeletionRemoteDataSource, required this.apiErrorHandler}) : _accountDeletionRemoteDataSource = accountDeletionRemoteDataSource;
  @override
  Future<Either<Failure, void>> accountDeletionRequested({required String reason})async {
    try {
      final result = await _accountDeletionRemoteDataSource.accountDeletionRequested(reason: reason);
      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
  
}