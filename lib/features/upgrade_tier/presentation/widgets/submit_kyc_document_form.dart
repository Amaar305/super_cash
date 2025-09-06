import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';

class SubmitKycDocumentForm extends StatelessWidget {
  const SubmitKycDocumentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xlg,
      children: [
        SubmitKycDocumentIDTypeField(),
        SubmitKycDocumentBVNNumberField(),
      ],
    );
  }
}
