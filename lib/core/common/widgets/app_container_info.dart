import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class AppContainerInfo extends StatelessWidget {
  const AppContainerInfo({super.key, this.child, required this.infoLabel});
  final Widget? child;
  final String infoLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md + 2,
      ),
      decoration: BoxDecoration(
        // color: Color(0x0B171B2A),
        borderRadius: BorderRadius.circular(6),
        color: AppColors.white,
        // borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary2.withValues(alpha: 0.08),
            offset: Offset(0, 2),
            blurRadius: 9,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        spacing: AppSpacing.sm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.xxs,
            children: [
              Icon(Icons.info, size: AppSpacing.lg),
              Text(
                infoLabel,
                style: poppinsTextStyle(
                  fontSize: AppSpacing.md,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
            ],
          ),
          child ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
