import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../manage_beneficiary.dart';

abstract interface class BeneficiaryRepositories {
  Future<Either<Failure, BeneficiaryResponse>> fetchBeneficiary(int page);
  Future<Either<Failure, Beneficiary>> saveBeneficiary({
    required String name,
    required String phone,
    required String network,
  });
  Future<Either<Failure, Beneficiary>> updateBeneficiary({
    required String id,
    String? name,
    String? phone,
    String? network,
  });
  Future<Either<Failure, void>> deleteBeneficiary({required String id});
}
