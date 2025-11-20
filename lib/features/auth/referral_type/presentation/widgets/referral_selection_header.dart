import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class ReferralSelectionHeader extends StatelessWidget {
  const ReferralSelectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.md,
          children: [
            Assets.icons.mingcuteCelebrateLine.svg(),
            Expanded(
              child: Text(
                'Select the referral type that suites you best.',
                textAlign: TextAlign.center,
                style: poppinsTextStyle(),
              ),
            ),
            Assets.icons.mingcuteCelebrateLine2.svg(),
          ],
        ),
        Text(
          'Select your desired "Welcome Referral for Cash" and earn the amount stated from below list.',
          textAlign: TextAlign.center,
          style: poppinsTextStyle(fontSize: AppSpacing.md, ),
        ),
      ],
    );
  }
}
