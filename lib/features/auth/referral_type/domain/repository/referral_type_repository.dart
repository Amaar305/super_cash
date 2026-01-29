import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/auth/referral_type/domain/entities/entities.dart';

abstract interface class ReferralTypeRepository {
  Future<Either<Failure, ReferralTypeResult>> fetchCompains();
  Future<Either<Failure, ReferralTypeEnrolResult>> enrollCompain({ String? campaignId});
}
