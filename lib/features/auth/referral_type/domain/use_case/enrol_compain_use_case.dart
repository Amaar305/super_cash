import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/auth/referral_type/domain/domain.dart';

class EnrolCompainUseCase
    implements UseCase<ReferralTypeEnrolResult, EnrolCompainParams> {
  final ReferralTypeRepository referralTypeRepository;

  EnrolCompainUseCase({required this.referralTypeRepository});

  @override
  Future<Either<Failure, ReferralTypeEnrolResult>> call(
    EnrolCompainParams param,
  ) async {
    return await referralTypeRepository.enrollCompain(
      campaignId: param.compainId,
    );
  }
}

class EnrolCompainParams {
  final String compainId;

  const EnrolCompainParams({required this.compainId});
}
