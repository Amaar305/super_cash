import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_home_address/cubit/kyc_home_address_cubit.dart';

class KycHomeAddressCountryField extends StatelessWidget {
  const KycHomeAddressCountryField({super.key});

  @override
  Widget build(BuildContext context) {
    final country = context.select(
      (KycHomeAddressCubit c) => c.state.country,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('Country'),
        AppDropdownField.underlineBorder(
          items: const ['Nigeria'],
          filled: Config.filled,
          hintText: 'Select country',
          initialValue: country,
          onChanged: (val) =>
              context.read<KycHomeAddressCubit>().onCountrySelected(val),
        ),
      ],
    );
  }
}
