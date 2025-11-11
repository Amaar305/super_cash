import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';

import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/auth.dart';
import 'package:super_cash/features/enable_biometric/enable_biometric.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (LoginCubit element) => element.state.status.isLoading,
    );

    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.login,
      onPressed: () => context.read<LoginCubit>().submit(
        onSuccess: context.read<AppCubit>().userLoggedIn,
        onEnableBiometric: (user) {
          // context.goNamedSafe(AppRoutes.enableBiometric, extra: user);

          // context.read<AppCubit>().enableBiometric(user);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnableBiometricPage(user: user),
            ),
          );
        },
      ),
    );
  }
}
