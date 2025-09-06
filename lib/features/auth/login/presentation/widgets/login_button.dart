import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/enable_biometric/enable_biometric.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../auth.dart';

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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CreatePinPage()),
            (route) => true,
          );
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
