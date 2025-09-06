import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/referal/referal.dart';

class FetchMyReferralsUseCase implements UseCase<List<ReferralUser>, NoParam> {
  final ReferalRepository referalRepository;

  FetchMyReferralsUseCase({required this.referalRepository});

  @override
  Future<Either<Failure, List<ReferralUser>>> call(NoParam param) async {
    return await referalRepository.fetchMyReferrals();
  }
}
