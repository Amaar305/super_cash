import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class HowItWorksButton extends StatelessWidget {
  const HowItWorksButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'How it works',
      textStyle: poppinsTextStyle(
        fontSize: AppSpacing.md,
        color: AppColors.white,
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: Size(108, 38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(color: AppColors.white),
        ),
        backgroundColor: AppColors.blue,
        padding: EdgeInsets.all(12),
      ),
    );
  }
}
