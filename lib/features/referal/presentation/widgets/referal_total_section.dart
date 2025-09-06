import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class ReferalTotalSection extends StatelessWidget {
  const ReferalTotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment(0, 0),
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReferalTotalNumberLabel(
            label: AppStrings.totalNumberOfReferal,
            totalNumber: '0',
          ),
          ReferalTotalNumberLabel(
            label: AppStrings.totalNumberOfRegistered,
            totalNumber: '0',
          ),
        ],
      ),
    );
  }
}
