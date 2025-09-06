import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth.dart';

class NoBiometricPage extends StatelessWidget {
  const NoBiometricPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap.v(AppSpacing.xxxlg * 2),

          AuthContainer(
            child: Column(
              children: [
                Icon(
                  Icons.info_outline,
                  size: AppSpacing.xxxlg / 1.2,
                  color: AppColors.primary2,
                ),
                Gap.v(AppSpacing.lg),
                Text(
                  'Oops!',
                  style: context.bodyMedium?.copyWith(fontSize: AppSpacing.xlg),
                ),
                Gap.v(AppSpacing.md),
                Text(
                  'Biometric login is not set up on this device. Login with password to  activate it.',
                  textAlign: TextAlign.center,
                  style: context.bodyMedium?.copyWith(
                    fontSize: AppSpacing.lg,
                    fontFamily: 'MonaSans',
                    fontWeight: AppFontWeight.black,
                    height: 1.6,
                  ),
                ),
                Gap.v(AppSpacing.xlg),
                PrimaryButton(
                  label: 'Login with Password',
                  onPressed: context.read<LoginCubit>().switchToPasswordLogin,
                )
              ],
            ),
          ),
          // Gap.v(AppSpacing.xxlg * 8),
        ],
      ),
    );
  }
}
