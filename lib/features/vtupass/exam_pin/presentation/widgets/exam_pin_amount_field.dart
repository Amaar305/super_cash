import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

class ExamPinAmountField extends StatelessWidget {
  const ExamPinAmountField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.enterAmount,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField(
          hintText: AppStrings.enterAmount,
          filled: Config.filled,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
