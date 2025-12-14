import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/helper/fingerprint_authentication.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

class EnableBiometricPage extends StatelessWidget {
  const EnableBiometricPage({super.key, required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xlg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpacing.lg,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _skip(context),
                    child: Text(
                      'Skip',
                      style: poppinsTextStyle(
                        color: colorScheme.primary,
                        fontSize: textTheme.labelLarge?.fontSize,
                        fontWeight: textTheme.labelLarge?.fontWeight,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.xlg),
                      decoration: BoxDecoration(
                        // color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.lg),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withValues(alpha: 0.05),
                        //     blurRadius: 20,
                        //     offset: const Offset(0, 12),
                        //   ),
                        // ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: AppSpacing.md,
                        children: [
                          Container(
                            height: 96,
                            width: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.primary.withValues(
                                alpha: 0.12,
                              ),
                            ),
                            child: Icon(
                              Icons.fingerprint_rounded,
                              size: 56,
                              color: colorScheme.primary,
                            ),
                          ),
                          Text(
                            'Set up biometric unlock',
                            style: poppinsTextStyle(
                              fontSize: textTheme.titleLarge?.fontSize,
                              fontWeight: FontWeight.w700,
                              color: textTheme.titleLarge?.color ??
                                  colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Use your fingerprint to sign in instantly and keep your account secure.',
                            style: poppinsTextStyle(
                              fontSize: textTheme.bodyMedium?.fontSize,
                              fontWeight: textTheme.bodyMedium?.fontWeight,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                PrimaryButton(
                  label: 'Enable Biometric',
                  onPressed: () => _enableBiometric(context),
                ),
                Text(
                  'We only store your biometric preference on this device.',
                  style: poppinsTextStyle(
                    fontSize: textTheme.bodySmall?.fontSize,
                    fontWeight: textTheme.bodySmall?.fontWeight,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _enableBiometric(BuildContext context) async {
    await fingerprintAuthentication(
      onUnAuthenticated: (p0) {
        openSnackbar(SnackbarMessage.error(title: p0), clearIfQueue: true);
      },
      onAuthenticated: () {
        serviceLocator<TokenRepository>().setBiometricEnabled(enable: true);

        // if (!user.isVerified) {
        //   context.read<AppCubit>().verifyAccount(user);
        //   return;
        // }

        if (!user.transactionPin) {
          context.read<AppCubit>().createPin(user);
          return;
        }

        context.read<AppCubit>().userLoggedIn(user);
      },
    );
  }

  void _skip(BuildContext context) {
    serviceLocator<TokenRepository>().setBiometricEnabled(enable: false);

    context.read<AppCubit>().userLoggedIn(user);
  }
}
