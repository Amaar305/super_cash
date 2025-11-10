import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class BonusTitle extends StatelessWidget {
  const BonusTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xs,
      children: [
        Text(
          'Transfer your bonus!',
          style: context.titleSmall,
          textAlign: TextAlign.center,
        ),
        Text(
          'Transfer your bonus to wallet or your preferred bank.',
          style: context.bodySmall,
          textAlign: TextAlign.center,
        ),
        Divider(color: AppColors.brightGrey, thickness: 1),
        Gap.v(AppSpacing.md),
      ],
    );
  }
}
