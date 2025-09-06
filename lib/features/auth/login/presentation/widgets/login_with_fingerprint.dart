import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:token_repository/token_repository.dart';

class LoginWithFingerprint extends StatelessWidget {
  const LoginWithFingerprint({super.key});
  @override
  Widget build(BuildContext context) {
    final hasBiometric =
        serviceLocator<TokenRepository>().getBiometric() ?? false;
    final user = serviceLocator<LoginLocalDataSource>().getUser();

    if (!hasBiometric) {
      return const Center(child: NoBiometricPage());
    }

    if (user == null) {
      // Handle case where user is null but biometric is enabled
      return Center(child: Text('User data not available'));
    }
    return const FingerprintLoginContent();
  }
}
