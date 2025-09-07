import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

import 'how_it_works_button.dart';

class ReferralHeader extends StatelessWidget {
  const ReferralHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 110,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xff063A53),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  'Invite New users to get cash',
                  style: poppinsTextStyle(
                    color: AppColors.white,
                    fontSize: AppSpacing.md,
                  ),
                ),
                Text(
                  'Refer\nand Earn',
                  style: poppinsTextStyle(
                    color: AppColors.white,
                    fontSize: AppSpacing.xlg,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          HowItWorksButton(),
        ],
      ),
    );
  }
}
