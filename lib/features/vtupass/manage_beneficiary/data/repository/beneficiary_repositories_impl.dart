import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../manage_beneficiary.dart';

class BeneficiaryRepositoriesImpl implements BeneficiaryRepositories {
  final BeneficiaryRemoteDataSource remoteDataSource;
  // final BeneficiaryLocalDataSource localDataSource;
  final ApiErrorHandler apiErrorHandler;

  BeneficiaryRepositoriesImpl({
    required this.remoteDataSource,
    required this.apiErrorHandler,
    // required this.localDataSource,
  });

  @override
  Future<Either<Failure, BeneficiaryResponse>> fetchBeneficiary(
    int page,
  ) async {
    try {
      final response = await remoteDataSource.fetchBeneficiary(page);
      return Right(response);
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, Beneficiary>> saveBeneficiary({
    required String name,
    required String phone,
    required String network,
  }) async {
    try {
      final beneficiary = await remoteDataSource.saveBeneficiary(
        name: name,
        phone: phone,
        network: network,
      );
      return Right(beneficiary);
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, Beneficiary>> updateBeneficiary({
    required String id,
    String? name,
    String? phone,
    String? network,
  }) async {
    try {
      final beneficiary = await remoteDataSource.updateBeneficiary(
        id: id,
        name: name,
        phone: phone,
        network: network,
      );
      return Right(beneficiary);
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBeneficiary({required String id}) async {
    try {
      await remoteDataSource.deleteBeneficiary(id: id);
      return const Right(null);
    } catch (error) {
      return Left(apiErrorHandler.handleError(error));
    }
  }
}
