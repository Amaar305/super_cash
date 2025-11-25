import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class ReferralWithdrawEraningsButton extends StatelessWidget {
  const ReferralWithdrawEraningsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: () => context.goNamedSafe(RNames.bonus),
      child: Container(
        width: 159,
        height: 46,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          border: Border.all(color: AppColors.deepBlue),
        ),
        child: Center(
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppSpacing.sm,
              children: [
                Text(
                  'Withdraw Earnings',
                  style: poppinsTextStyle(
                    fontSize: AppSpacing.md,
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.deepBlue,
                  ),
                ),
                Icon(Icons.wallet_outlined, color: AppColors.deepBlue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
