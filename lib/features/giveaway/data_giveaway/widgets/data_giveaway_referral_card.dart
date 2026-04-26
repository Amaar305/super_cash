import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class DataGiveawayReferralCard extends StatelessWidget {
  const DataGiveawayReferralCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xlg,
        AppSpacing.xxlg,
        AppSpacing.xlg,
        AppSpacing.xxlg,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FE),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Refer & Earn Boosters',
            style: poppinsTextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF14223A),
            ),
          ),
          const Gap.v(AppSpacing.md),
          Text(
            'Invite friends to join Data Ether and unlock guaranteed 1GB tokens '
            'for every successful signup.',
            style: poppinsTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF596273),
            ).copyWith(height: 1.6),
          ),
          const Gap.v(AppSpacing.xlg),
          Center(
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF0D1E3A),
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 34,
                  vertical: AppSpacing.lg,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                textStyle: poppinsTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Share Now'),
                  Gap.h(AppSpacing.sm),
                  Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
