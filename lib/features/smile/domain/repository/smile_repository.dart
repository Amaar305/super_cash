import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/smile/domain/domain.dart';

abstract interface class SmileRepository {
  Future<Either<Failure, SmilePlanResponse>> fetchPlans();

  Future<Either<Failure, SmileVerificationResult>> verifyEmail({
    required String email,
  });

  Future<Either<Failure, TransactionResponse>> purchase({
    required String email,
    required String accountId,
    required String variationCode,
    required String phone,
  });

  Future<Either<Failure, SmileTransactionStatus>> queryTransactionStatus({
    required String reference,
  });
}
