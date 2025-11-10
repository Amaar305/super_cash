import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/bonus/bonus.dart';

class BonusRepositoryImpl implements BonusRepository {
  final BonusRemoteDataSource bonusRemoteDataSource;

  const BonusRepositoryImpl({required this.bonusRemoteDataSource});
  @override
  Future<Either<Failure, List<Bank>>> getBankLists() async {
    try {
      final result = await bonusRemoteDataSource.fetchBanks();
      return right(result);
    } on ServerException catch (error) {
      return left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sendMoney({
    required String accountNumber,
    required String bankCode,
    required String amount,
    required String accountName,
  }) async {
    try {
      final result = await bonusRemoteDataSource.sendMoney(
        accountNumber: accountNumber,
        bankCode: bankCode,
        amount: amount,
        accountName: accountName,
      );
      return right(result);
    } on ServerException catch (error) {
      return left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, ValidatedBank>> validateBankDetails({
    required String accountNumber,
    required String bankCode,
  }) async {
    try {
      final result = await bonusRemoteDataSource.validateBankDetails(
        accountNumber: accountNumber,
        bankCode: bankCode,
      );
      return right(result);
    } on ServerException catch (error) {
      return left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> withdrawBonus({
    required String amount,
  }) async {
    try {
      final result = await bonusRemoteDataSource.withdrawBonus(amount: amount);
      return right(result);
    } on ServerException catch (error) {
      return left(Failure(error.message));
    }
  }
}
