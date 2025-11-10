import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/bonus/domain/domain.dart';

abstract interface class BonusRepository {
  Future<Either<Failure, List<Bank>>> getBankLists();
  Future<Either<Failure, ValidatedBank>> validateBankDetails({
    required String accountNumber,
    required String bankCode,
  });

  Future<Either<Failure, Map<String, dynamic>>> sendMoney({
    required String accountNumber,
    required String bankCode,
    required String amount,
    required String accountName,
  });
  Future<Either<Failure, Map<String, dynamic>>> withdrawBonus({
    required String amount,
  });
}
