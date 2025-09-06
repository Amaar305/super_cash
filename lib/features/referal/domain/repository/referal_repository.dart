import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';

import '../entities/referral_result.dart';
import '../entities/referral_user.dart';

abstract interface class ReferalRepository {
  Future<Either<Failure, List<ReferralUser>>> fetchMyReferrals();
  Future<Either<Failure, ReferralResult>> claimMyRewards({
    required List<String> refereeIds,
    required String idms,
  });
}
