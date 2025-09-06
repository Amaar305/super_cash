import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

class ReferalLinkSection extends StatelessWidget {
  const ReferalLinkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        Text(
          AppStrings.yourUniqueReferalLink,
          style: TextStyle(
            fontWeight: AppFontWeight.medium,
            fontSize: AppSpacing.md,
          ),
        ),
        PurchaseContainerInfo(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    'https://Cool.mobileapp.com',
                    style: TextStyle(color: AppColors.deepBlue, fontSize: 10),
                  ),
                ),
                Tappable.scaled(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(Icons.copy_outlined, size: AppSize.iconSizeXSmall),
                      Gap.h(AppSpacing.sm),
                      Text(
                        AppStrings.copyLink,
                        style: TextStyle(
                          color: AppColors.deepBlue,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
