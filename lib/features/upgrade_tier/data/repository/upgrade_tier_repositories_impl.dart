import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/upgrade_tier/upgrade_tier.dart';
import 'package:fpdart/fpdart.dart';

class UpgradeTierRepositoriesImpl implements UpgradeTierRepositories {
  final UpgradeTierRemoteDataSource upgradeTierRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  UpgradeTierRepositoriesImpl({
    required this.upgradeTierRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> upgradeAccount({
    required UpgradeAccountProps props,
  }) async {
    try {
      // Upload the file image

      final imageUrl = await upgradeTierRemoteDataSource.uploadSelfieImage(
        file: props.selfieFile,
      );

      // Assign the url
      props = props.copyWith(selfie: imageUrl);

      // Send the request with the return file url
      final response = await upgradeTierRemoteDataSource.upgradeAccount(
        props: props,
      );

      return right(response);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, bool>> checkUpgradeStatus() async {
    try {
      final response = await upgradeTierRemoteDataSource.checkUpgradeStatus();
      return right(response);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
}
