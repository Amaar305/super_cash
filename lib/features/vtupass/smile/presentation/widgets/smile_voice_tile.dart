import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class SmileVoiceTile extends StatelessWidget {
  const SmileVoiceTile({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(6.54);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.04),
        borderRadius: radius,
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.lg,
            horizontal: AppSpacing.md,
          ),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 28,
                child: Assets.images.smile.image(),
              ),
              Gap.h(AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.sm,
                children: [
                  Text(
                    'SMILEVOICE ONLY 65',
                    style: TextStyle(
                      fontWeight: AppFontWeight.medium,
                      fontSize: AppSpacing.sm,
                    ),
                  ),
                  Text(
                    'N2,000',
                    style: TextStyle(
                      fontSize: AppSpacing.sm,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                width: 50,
                alignment: Alignment(0, 0),
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(3.27)),
                ),
                child: FittedBox(
                  child: Text(
                    '30Days',
                    style: TextStyle(
                      fontSize: AppSpacing.sm,
                      color: AppColors.white,
                      fontWeight: AppFontWeight.medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
