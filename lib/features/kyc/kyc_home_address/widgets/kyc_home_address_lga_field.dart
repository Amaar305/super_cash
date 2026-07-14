import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_home_address/cubit/kyc_home_address_cubit.dart';
import 'package:super_cash/features/upgrade_tier/utils/utils.dart';

class KycHomeAddressLgaField extends StatelessWidget {
  const KycHomeAddressLgaField({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedState = context.select(
      (KycHomeAddressCubit c) => c.state.selectedState,
    );
    final selectedLga = context.select(
      (KycHomeAddressCubit c) => c.state.selectedLga,
    );

    final lgas = selectedState != null
        ? (stateLgaMap[selectedState] ?? <String>[])
        : <String>[];

    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('LGA (optional)'),
        AppDropdownField.underlineBorder(
          items: lgas,
          filled: Config.filled,
          hintText: selectedState == null
              ? 'Select a state first'
              : 'Select LGA',
          initialValue: lgas.contains(selectedLga) ? selectedLga : null,
          onChanged: lgas.isEmpty
              ? null
              : (val) =>
                  context.read<KycHomeAddressCubit>().onLgaSelected(val),
        ),
      ],
    );
  }
}
