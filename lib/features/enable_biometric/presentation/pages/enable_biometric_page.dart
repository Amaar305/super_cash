import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/helper/fingerprint_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

class EnableBiometricPage extends StatelessWidget {
  const EnableBiometricPage({super.key, required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xlg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.md,
          children: [
            Text(
              "Would you like to enable biometric login for faster sign-ins?",
              textAlign: TextAlign.center,
              style: context.bodyMedium,
            ),
            PrimaryButton(
              label: 'Enable Biometric',
              onPressed: () async {
                await fingerprintAuthentication(
                  onUnAuthenticated: (p0) {
                    // Biometric not available
                    openSnackbar(
                      SnackbarMessage.error(title: p0),
                      clearIfQueue: true,
                    );
                  },
                  onAuthenticated: () {
                    serviceLocator<TokenRepository>().setBiometricEnabled(
                      enable: true,
                    );

                    if (!user.isVerified) {
                      context.read<AppCubit>().verifyAccount(user);
                      return;
                    }

                    if (!user.transactionPin) {
                      context.read<AppCubit>().createPin(user);
                      return;
                    }

                    context.read<AppCubit>().userLoggedIn(user);
                  },
                );
              },
            ),
            TextButton(
              onPressed: () {
                serviceLocator<TokenRepository>().setBiometricEnabled(
                  enable: false,
                );

                context.read<AppCubit>().userLoggedIn(user);
              },
              child: const Text("Skip"),
            ),
          ],
        ),
      ),
    );
  }
}
