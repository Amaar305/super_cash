import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';
import 'package:super_cash/features/upgrade_tier/utils/utils.dart';

class ProductAddressStateField  extends StatefulWidget {
  const ProductAddressStateField ({super.key});

  @override
  State<ProductAddressStateField > createState() =>
      _AddressVerificationStateFieldState();
}

class _AddressVerificationStateFieldState
    extends State<ProductAddressStateField > {
  late final ProductGiveawayCubit _cubit;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProductGiveawayCubit>();
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ProductGiveawayCubit cubit) => cubit.state.status.isLoading,
    );
    final selectedState = context.select(
      (ProductGiveawayCubit cubit) => cubit.state.state,
    );

    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.state),
        AppDropdownField.underlineBorder(
          items: states.map((state) => state.name).toList(),
          enabled: !isLoading,

          hintText: AppStrings.select,
          onChanged: (p0) => _debouncer.run(() => _cubit.onSelectState(p0)),
          initialValue: selectedState,
        ),
      ],
    );
  }
}
