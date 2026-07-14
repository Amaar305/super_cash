import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/kyc/kyc_government_id/cubit/kyc_government_id_cubit.dart';

class KycGovIdTypeField extends StatelessWidget {
  const KycGovIdTypeField({super.key});

  // Display label → API value
  static const _labelToType = {
    'International Passport': 'passport',
    "Driver's License": 'driver_license',
    'National Identity Card': 'national_id',
    "Voter's Card": 'voter_card',
  };

  static const _typeToLabel = {
    'passport': 'International Passport',
    'driver_license': "Driver's License",
    'national_id': 'National Identity Card',
    'voter_card': "Voter's Card",
  };

  @override
  Widget build(BuildContext context) {
    final selectedType = context.select(
      (KycGovernmentIdCubit c) => c.state.selectedDocumentType,
    );
    final error = context.select(
      (KycGovernmentIdCubit c) => c.state.selectedDocumentTypeError,
    );
    final isUploading = context.select(
      (KycGovernmentIdCubit c) => c.state.status.isUploading,
    );

    final selectedLabel =
        selectedType != null ? _typeToLabel[selectedType] : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.lg,
      children: [
        const FieldLabelTitle('ID Type'),
        AppDropdownField.underlineBorder(
          enabled: !isUploading,
          filled: Config.filled,
          hintText: 'Select ID type',
          items: _labelToType.keys.toList(),
          initialValue: selectedLabel,
          errorText: error,
          onChanged: (label) {
            final type = label != null ? _labelToType[label] : null;
            context.read<KycGovernmentIdCubit>().onDocumentTypeSelected(type);
          },
        ),
      ],
    );
  }
}
