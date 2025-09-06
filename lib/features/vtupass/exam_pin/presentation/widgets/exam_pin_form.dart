import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class ExamPinForm extends StatelessWidget {
  const ExamPinForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xlg,
      children: [
        ExamPinAmountField(),
        ExamPinQuanitityField(),
        ExamPinTotalAmountField(),
      ],
    );
  }
}
