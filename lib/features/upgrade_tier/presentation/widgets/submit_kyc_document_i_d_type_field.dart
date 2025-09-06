import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/upgrade_tier/upgrade_tier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitKycDocumentIDTypeField extends StatelessWidget {
  const SubmitKycDocumentIDTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (UpgradeTierCubit element) => element.state.status.isLoading,
    );
    final selectedIdType = context.select(
      (UpgradeTierCubit element) => element.state.selectedIdType,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.selectIDType),
        AppDropdownField.underlineBorder(
          enabled: !isLoading,
          items: ['BVN'],
          filled: Config.filled,
          hintText: AppStrings.select,
          initialValue: selectedIdType,
          onChanged: (p0) {
            context.read<UpgradeTierCubit>().onIdTypeSelected(p0);
          },
        ),
      ],
    );
  }
}
