import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/upgrade_tier/presentation/widgets/submit_kyc_button.dart';
import 'package:super_cash/features/upgrade_tier/presentation/widgets/submit_kyc_document_form.dart';
import 'package:super_cash/features/upgrade_tier/presentation/widgets/submit_kyc_selfie_widget.dart';
import 'package:flutter/material.dart';

class SubmitKycDocumentPage extends StatelessWidget {
  const SubmitKycDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xlg,
      children: [
        SubmitKycDocumentForm(),
        SubmitKycSelfieWidget(),
        SubmitKycButton(),
      ],
    );
  }
}
