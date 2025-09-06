import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_strings/app_string.dart';

class CardTermsOfUsageSection extends StatelessWidget {
  const CardTermsOfUsageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: AppStrings.cardTermsOfUsagesList
          .map(
            (terms) => Row(
              spacing: AppSpacing.sm,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              children: [
                Icon(
                  Icons.circle,
                  color: AppColors.buttonColor,
                  size: AppSize.iconSizeXSmall / 1.6,
                ),
                Flexible(
                  child: Text(
                    terms,
                    style: MonaSansTextStyle.label(
                      fontSize: AppSpacing.md - 1,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
