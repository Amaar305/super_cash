import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.actionText,
  });

  final String title;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: poppinsTextStyle(
            fontSize: 14,
            fontWeight: AppFontWeight.bold,
            color: Color(0xFF0B1228),
          ),
        ),
        const Spacer(),
        Text(
          actionText,
          style: poppinsTextStyle(
            fontSize: 13,
            fontWeight: AppFontWeight.black,
            color: AppColors.blue,
          ),
        ),
      ],
    );
  }
}
