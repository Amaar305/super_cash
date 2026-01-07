import 'package:envied/envied.dart';

part 'env.prod.g.dart';

/// {@template env}
/// Prod Environment variables. Used to access environment variables in the app.
/// {@endtemplate}
@Envied(path: '.env.prod', obfuscate: true)
abstract class EnvProd {
  /// App Base URL.
  @EnviedField(varName: 'APP_BASE_URL', obfuscate: true)
  static String appBaseUrl = _EnvProd.appBaseUrl;

  /// Play Store URL.
  @EnviedField(varName: 'PLAY_STORE_URL', obfuscate: true)
  static String playStoreUrl = _EnvProd.playStoreUrl;

  /// App Store URL.
  @EnviedField(varName: 'APP_STORE_URL', obfuscate: true)
  static String appStoreUrl = _EnvProd.appStoreUrl;
}
