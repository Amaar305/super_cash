import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/upgrade_tier/upgrade_tier.dart';

import 'package:flutter/material.dart';

class VerifyRegisteredDetailsForm extends StatelessWidget {
  const VerifyRegisteredDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xlg,
      children: [
        VerifyRegisteredDetailsFirstNameField(),
        VerifyRegisteredDetailsLastNameField(),
        VerifyRegisteredDetailsEmailField(),
        VerifyRegisteredDetailsPhoneNumberField(),
      ],
    );
  }
}
