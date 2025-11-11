import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/auth/referral_type/domain/entities/referral_type_result.dart';
import 'package:super_cash/features/auth/referral_type/domain/repository/referral_type_repository.dart';

class FetchCompainsUseCase implements UseCase<ReferralTypeResult, NoParam> {
  final ReferralTypeRepository referralTypeRepository;

 const FetchCompainsUseCase({required this.referralTypeRepository});

  @override
  Future<Either<Failure, ReferralTypeResult>> call(NoParam param) async {
    return referralTypeRepository.fetchCompains();
  }
}
