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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     colorScheme.primary.withValues(alpha: 0.06),
            //     colorScheme.surface,
            //   ],
            // ),
          ),
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
                    child: const Text('Skip'),
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
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Use your fingerprint to sign in instantly and keep your account secure.',
                            style: textTheme.bodyMedium?.copyWith(
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
                  style: textTheme.bodySmall?.copyWith(
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
  }

  void _skip(BuildContext context) {
    serviceLocator<TokenRepository>().setBiometricEnabled(enable: false);

    context.read<AppCubit>().userLoggedIn(user);
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle_rounded, size: 18, color: colorScheme.primary),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: Text(
            label,
            style: context.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
