import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/upgrade_tier/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class UpgradeAccountUseCase
    implements UseCase<Map<String, dynamic>, UpgradeAccountProps> {
  final UpgradeTierRepositories upgradeTierRepositories;

  UpgradeAccountUseCase({required this.upgradeTierRepositories});
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    UpgradeAccountProps param,
  ) async {
    return await upgradeTierRepositories.upgradeAccount(props: param);
  }
}
