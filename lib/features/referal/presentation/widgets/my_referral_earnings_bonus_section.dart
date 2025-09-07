import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/referal/presentation/widgets/widgets.dart';

class MyReferralEarningsBonusSection extends StatelessWidget {
  const MyReferralEarningsBonusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.05),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.sm,
            children: [
              Text(
                'My Referral Bonus',
                style: poppinsTextStyle(
                  fontSize: AppSpacing.md,
                  fontWeight: AppFontWeight.light,
                ),
              ),
              ReferralEarningBonus(),
            ],
          ),
          ReferralWithdrawEraningsButton(),
        ],
      ),
    );
  }
}
