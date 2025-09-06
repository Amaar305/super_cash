import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

class ExamPinTotalAmountField extends StatelessWidget {
  const ExamPinTotalAmountField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.totalAmount,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField(
          hintText: '0.0',
          filled: Config.filled,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
