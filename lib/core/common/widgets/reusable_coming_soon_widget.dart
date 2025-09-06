import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/auth/widgets/auth_social_container.dart';
import 'package:flutter/material.dart';

class ReusableComingSoonWidget extends StatelessWidget {
  const ReusableComingSoonWidget({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Center(
        child: AuthContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info_outline,
                size: AppSpacing.xxxlg / 1.2,
                color: AppColors.primary2,
              ),
              Gap.v(AppSpacing.lg),
              Text(
                'Coming Soon!',
                style: context.bodyMedium?.copyWith(fontSize: AppSpacing.xlg),
              ),
              Gap.v(AppSpacing.md),
              Text(
                text,
                textAlign: TextAlign.center,
                style: context.bodyMedium?.copyWith(
                  fontSize: AppSpacing.lg,
                  fontFamily: 'MonaSans',
                  fontWeight: AppFontWeight.light,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
