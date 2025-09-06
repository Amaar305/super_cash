import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginTypeTabs extends StatelessWidget {
  const LoginTypeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    final isPasswordLogin = context.select(
      (LoginCubit cubit) => cubit.state.isPasswordLogin,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: AppTab(
        children: [
          AppTabItem(
            label: 'With Password',
            activeTab: isPasswordLogin,
            onTap: cubit.switchToPasswordLogin,
          ),
          AppTabItem(
            label: 'With Fingerprint',
            activeTab: !isPasswordLogin,
            onTap: cubit.switchToBiometricLogin,
          ),
        ],
      ),
    );
  }
}
