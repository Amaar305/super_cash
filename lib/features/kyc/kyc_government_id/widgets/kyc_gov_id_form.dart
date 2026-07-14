import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/kyc/kyc_government_id/cubit/kyc_government_id_cubit.dart';
import 'package:super_cash/features/kyc/kyc_government_id/widgets/kyc_gov_id_image_preview.dart';
import 'package:super_cash/features/kyc/kyc_government_id/widgets/kyc_gov_id_number_field.dart';
import 'package:super_cash/features/kyc/kyc_government_id/widgets/kyc_gov_id_picker_buttons.dart';
import 'package:super_cash/features/kyc/kyc_government_id/widgets/kyc_gov_id_type_field.dart';

class KycGovIdForm extends StatelessWidget {
  const KycGovIdForm({super.key, required this.onImageTap});

  final VoidCallback onImageTap;

  @override
  Widget build(BuildContext context) {
    final alreadySubmitted = context.select(
      (KycGovernmentIdCubit c) => c.state.alreadySubmitted,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xlg,
      children: [
        const KycGovIdTypeField(),
        const KycGovIdNumberField(),
        if (alreadySubmitted) _SubmittedBadge(),
        KycGovIdImagePreview(onTap: onImageTap),
        const KycGovIdPickerButtons(),
      ],
    );
  }
}

class _SubmittedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A7C4E).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.xs,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 16,
            color: Color(0xFF1A7C4E),
          ),
          Expanded(
            child: Text(
              'Document already submitted — you can update it below.',
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF1A7C4E),
                fontWeight: AppFontWeight.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
