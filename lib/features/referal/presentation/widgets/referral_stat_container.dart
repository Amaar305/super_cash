import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class ReferralStatContainer extends StatelessWidget {
  const ReferralStatContainer({
    super.key,
    required this.title,
    required this.subtitle,
    this.color,
    this.width,
  });

  final String title;
  final String subtitle;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final boldText = color != null;
    return Container(
      width: width,
      height: 76,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.05),
      ),
      alignment: Alignment.center,
      child: Column(
        spacing: AppSpacing.sm,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: poppinsTextStyle(
              fontWeight: boldText ? AppFontWeight.bold : null,
              fontSize: !boldText ? AppSpacing.md : null,
              color: color,
            ),
          ),
          FittedBox(
            child: Text(
              subtitle,

              textAlign: TextAlign.center,
              maxLines: 2,
              style: poppinsTextStyle(
                fontWeight: AppFontWeight.bold,
                fontSize: AppSpacing.lg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
