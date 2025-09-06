import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/upgrade_tier/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UpgradeTierRepositories {
  Future<Either<Failure, Map<String, dynamic>>> upgradeAccount({
    required UpgradeAccountProps props,
  });

  Future<Either<Failure, bool>> checkUpgradeStatus();
}
