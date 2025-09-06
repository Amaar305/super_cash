import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/referal/domain/domain.dart';

class ClaimMyRewardsUseCase
    implements UseCase<ReferralResult, ClaimMyRewardsParams> {
  final ReferalRepository referalRepository;

  const ClaimMyRewardsUseCase({required this.referalRepository});
  @override
  Future<Either<Failure, ReferralResult>> call(
    ClaimMyRewardsParams param,
  ) async {
    return await referalRepository.claimMyRewards(
      refereeIds: param.refereeIds,
      idms: param.idempotencyKey,
    );
  }
}

class ClaimMyRewardsParams extends Equatable {
  final List<String> refereeIds;
  final String idempotencyKey;

  const ClaimMyRewardsParams({
    required this.refereeIds,
    required this.idempotencyKey,
  });

  @override
  List<Object?> get props => [refereeIds, idempotencyKey];
}
