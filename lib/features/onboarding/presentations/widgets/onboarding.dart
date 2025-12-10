import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/onboarding/presentations/pages/onboarding_page.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key, required this.onboardingData});
  final OnboardingData onboardingData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 299,
          height: 333,
          decoration: BoxDecoration(
            // Image goes here
            borderRadius: BorderRadius.circular(18),
            color: AppColors.brightGrey,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: onboardingData.image,
          ),
        ),
        Gap.v(AppSpacing.xxlg),
        Text(
          onboardingData.title,
          style: poppinsTextStyle(
            fontSize: AppSpacing.xlg,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        Gap.v(AppSpacing.md),
        Text(
          onboardingData.description,
          style: poppinsTextStyle(
            // fontSize: AppSpacing.xlg,
            fontWeight: AppFontWeight.regular,
            // letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
