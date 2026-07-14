import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_home_address/cubit/kyc_home_address_cubit.dart';
import 'package:super_cash/features/upgrade_tier/utils/utils.dart';

class KycHomeAddressStateField extends StatelessWidget {
  const KycHomeAddressStateField({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = context.select(
      (KycHomeAddressCubit c) => c.state.selectedState,
    );
    final error = context.select(
      (KycHomeAddressCubit c) => c.state.selectedStateError,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('State'),
        AppDropdownField.underlineBorder(
          items: stateLgaMap.keys.toList(),
          filled: Config.filled,
          hintText: 'Select state',
          initialValue: selected,
          errorText: error?.isEmpty == true ? null : error,
          onChanged: (val) =>
              context.read<KycHomeAddressCubit>().onStateSelected(val),
        ),
      ],
    );
  }
}
