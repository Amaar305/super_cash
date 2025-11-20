import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class ReferralTypeHeader extends StatelessWidget {
  const ReferralTypeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.md,
      children: [
        Text(
          'How would you like to continue?',
          textAlign: TextAlign.center,
          style: poppinsTextStyle(
            fontSize: 18,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),

        Text(
          'Please select your preferred referral type to proceed with the registration process.',
          style: poppinsTextStyle(
            color: AppColors.grey,
            fontSize: AppSpacing.md,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
