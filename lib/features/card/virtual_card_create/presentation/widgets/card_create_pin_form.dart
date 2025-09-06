
import 'package:app_ui/app_ui.dart';

import 'package:flutter/material.dart';

import '../../virtual_card_create.dart';

class CardCreatePinForm extends StatelessWidget {
  const CardCreatePinForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xxlg,
      children: [
        CardCreateAmountField(),
        CardCardPinField(),
        CardConfirmCardPinField(),
      ],
    );
  }
}
