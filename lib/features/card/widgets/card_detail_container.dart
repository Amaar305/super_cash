import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class CardDetailContainer extends StatelessWidget {
  const CardDetailContainer({
    super.key,
    required this.text,
    required this.text2,
    this.color,
  });
  final String text;
  final String text2;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return PurchaseContainerInfo(
      useWidth: false,
      radius: AppSpacing.md + 2,
      color: color,
      child: Text.rich(
        style: poppinsTextStyle(fontSize: AppSpacing.md),
        TextSpan(
          text: text,
          children: [
            TextSpan(
              text: text2,
              style: poppinsTextStyle(
                color: AppColors.deepBlue,
                fontWeight: AppFontWeight.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
