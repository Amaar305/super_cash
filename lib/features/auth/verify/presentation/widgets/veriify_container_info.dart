import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

class VeriifyContainerInfo extends StatelessWidget {
  const VeriifyContainerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.sm * 2),
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            Icon(
              Icons.info,
              size: AppSize.iconSizeSmall,
              color: AppColors.blue,
            ),
            Flexible(
              child: Text(
                AppStrings.verifyAccountInstruction,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
