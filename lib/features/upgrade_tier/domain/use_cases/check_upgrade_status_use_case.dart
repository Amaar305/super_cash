import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/upgrade_tier/upgrade_tier.dart';
import 'package:fpdart/fpdart.dart';

class CheckUpgradeStatusUseCase implements UseCase<bool, NoParam> {
  final UpgradeTierRepositories upgradeTierRepositories;

  CheckUpgradeStatusUseCase({required this.upgradeTierRepositories});

  @override
  Future<Either<Failure, bool>> call(NoParam param) async {
    return await upgradeTierRepositories.checkUpgradeStatus();
  }
}
