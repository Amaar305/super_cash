import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract interface class AddFundRepository {
  Future<Either<Failure, String>> generateAccount({required String bvn});
  Future<Either<Failure, List<Account>>> fetchBankAccounts();
}
