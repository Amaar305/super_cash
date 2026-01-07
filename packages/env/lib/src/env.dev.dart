import 'package:envied/envied.dart';

part 'env.dev.g.dart';

/// {@template env}
/// Dev Environment variables. Used to access environment variables in the app.
/// {@endtemplate}
@Envied(path: '.env.dev', obfuscate: true)
abstract class EnvDev {

  /// App Base URL.
  @EnviedField(varName: 'APP_BASE_URL', obfuscate: true)
  static String appBaseUrl = _EnvDev.appBaseUrl;

  /// Play Store URL.
  @EnviedField(varName: 'PLAY_STORE_URL', obfuscate: true)
  static String playStoreUrl = _EnvDev.playStoreUrl;

  /// App Store URL.
  @EnviedField(varName: 'APP_STORE_URL', obfuscate: true)
  static String appStoreUrl = _EnvDev.appStoreUrl;
 
}
