import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class ConfirmBottomFingerprint extends StatelessWidget {
  const ConfirmBottomFingerprint({super.key, this.onVerified});
  final VoidCallback? onVerified;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),

      width: double.infinity,
      color: AppColors.lightBlue.withValues(alpha: 0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.lg,
        children: [
          Text(
            'Secure & Quick Payment',
            style: poppinsTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),

          Tappable.scaled(
            onTap: onVerified,
            child: Container(
              padding: EdgeInsets.all(AppSpacing.md),
              width: context.screenWidth * 0.6,
              decoration: BoxDecoration(
                color: AppColors.blue.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.blue.withValues(alpha: 0.32),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,

              child: Row(
                spacing: AppSpacing.sm,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.fingerprint, size: 32, color: AppColors.blue),

                  Text(
                    AppStrings.authPaymentText(isAndroid: context.isAndroid),
                    style: poppinsTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
