import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared/shared.dart';

Future<void> fingerprintAuthentication({
  void Function(String)? onUnAuthenticated,
  required VoidCallback onAuthenticated,
  String? reason,
}) async {
  final auth = serviceLocator<LocalAuthentication>();
  final isSupported = serviceLocator<bool>();
  // final canCheck = await auth.canCheckBiometrics;
  // final isAvailable = await auth.isDeviceSupported();
  // if (canCheck && isAvailable) {
  //   final didAuthenticate = await localAuth.authenticate(
  //     localizedReason: 'Enable biometric login',
  //   );

  //   if (didAuthenticate) {
  //     await tokenStorage.setBiometricEnabled(true);
  //     context.go('/home');
  //   }
  // } else {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Biometric not available")),
  //   );
  // }
  try {
    if (!isSupported) {
      openSnackbar(
        SnackbarMessage.error(title: 'This device is not supported'),
        clearIfQueue: true,
      );
      return;
    }
    bool authenticated = await auth.authenticate(
      localizedReason: reason ?? 'Use your fingerprint to authenticate.',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: false,
      ),
      // authMessages:[]
    );

    if (!authenticated) {
      onUnAuthenticated?.call("Couldn't authenticated");
      return;
    }

    // Process transaction
    onAuthenticated();
  } on PlatformException catch (error, stackTrace) {
    logE('Fingerprint authentication error: $error', stackTrace: stackTrace);

    onUnAuthenticated?.call("Couldn't authenticated");
  }
}
