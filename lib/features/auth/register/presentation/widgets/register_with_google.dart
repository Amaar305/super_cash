import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../../../widgets/auth_social_container.dart';

class RegisterWithGoogle extends StatelessWidget {
  const RegisterWithGoogle({super.key});

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
                  'Coming soon!',
                  style: context.bodyMedium?.copyWith(fontSize: AppSpacing.xlg),
                ),
                Gap.v(AppSpacing.md),
                Text(
                  'Sign up with google is coming soon.',
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
                  label: 'Sign up with Google',
                  // onPressed: () {},
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
