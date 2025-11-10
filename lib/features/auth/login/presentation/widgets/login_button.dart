import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';

import 'package:super_cash/features/enable_biometric/enable_biometric.dart';

import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/auth.dart';

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
        onSuccess: () {
          final loginCubit = context.read<LoginCubit>();
          final user = loginCubit.state.user;

          if (user == null) {
            // context.go(AppRoutes.dashboard);
            return;
          }

          if (!user.transactionPin) {
            Navigator.pushAndRemoveUntil(
              context,
              CreatePinPage.route(),
              (_) => true,
            );
            return;
          }

          if (!user.isVerified) {
            Navigator.pushAndRemoveUntil(
              context,
              VerifyPage.route(email: user.email),
              (_) => true,
            );
            return;
          }

          context.read<AppBloc>().add(UserLoggedIn(user));
        },
        onEnableBiometric: (user) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnableBiometricPage(user: user),
            ),
          );
          // context.push(
          //   AppRoutes.enableBiometric,
          //   extra: user,
          // );
        },
      ),
    );
  }
}
