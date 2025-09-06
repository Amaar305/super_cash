import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth.dart';

class AlreadyHaveAccountButton extends StatelessWidget {
  const AlreadyHaveAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Tappable.scaled(
      onTap: () => cubit.changeAuth(showLogin: true),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: AppStrings.alreadyHaveAnAccount,
            children: [
              TextSpan(
                text: AppStrings.login,
                style: const TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.blue,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
