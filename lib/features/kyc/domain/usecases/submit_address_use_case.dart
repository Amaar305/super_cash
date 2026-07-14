import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
import 'package:super_cash/features/kyc/domain/repository/kyc_repository.dart';

class KycAddressParams {
  final String country;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String houseNo;
  final String lga;

  const KycAddressParams({
    this.country = 'Nigeria',
    required this.address,
    required this.city,
    required this.state,
    this.postalCode = '',
    this.houseNo = '',
    this.lga = '',
  });
}

class SubmitAddressUseCase
    implements UseCase<KycActionResult<KycAddressResponse>, KycAddressParams> {
  final KycRepository kycRepository;
  SubmitAddressUseCase({required this.kycRepository});

  @override
  Future<Either<Failure, KycActionResult<KycAddressResponse>>> call(
          KycAddressParams param) =>
      kycRepository.submitAddress(
        country: param.country,
        address: param.address,
        city: param.city,
        state: param.state,
        postalCode: param.postalCode,
        houseNo: param.houseNo,
        lga: param.lga,
      );
}
