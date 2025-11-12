import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/home/domain/domain.dart';

class FetchAppSettingsUseCase
    implements UseCase<HomeSettings, FetchAppSettingsParams> {
  final HomeUserRepository homeUserRepository;

  const FetchAppSettingsUseCase({required this.homeUserRepository});

  @override
  Future<Either<Failure, HomeSettings>> call(
    FetchAppSettingsParams param,
  ) async {
    return await homeUserRepository.fetchAppSettings(
      platform: param.platform,
      version: param.version,
      versionCode: param.versionCode,
    );
  }
}

class FetchAppSettingsParams {
  final String platform;
  final String version;
  final String versionCode;

  const FetchAppSettingsParams({
    required this.platform,
    required this.version,
    required this.versionCode,
  });
}
