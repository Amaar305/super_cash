import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/cubit/kyc_personal_information_cubit.dart';

class KycPersonalInfoGenderField extends StatelessWidget {
  const KycPersonalInfoGenderField({super.key});

  static const _options = ['male', 'female'];

  @override
  Widget build(BuildContext context) {
    final gender = context.select(
      (KycPersonalInformationCubit c) => c.state.gender,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('Gender (optional)'),
        AppDropdownField.underlineBorder(
          items: _options,
          filled: Config.filled,
          hintText: 'Select gender',
          initialValue: gender,
          onChanged: (val) =>
              context.read<KycPersonalInformationCubit>().onGenderChanged(val),
        ),
      ],
    );
  }
}
