import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class AddressVerificationCountryField extends StatefulWidget {
  const AddressVerificationCountryField({super.key});

  @override
  State<AddressVerificationCountryField> createState() =>
      _AddressVerificationCountryFieldState();
}

class _AddressVerificationCountryFieldState
    extends State<AddressVerificationCountryField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onSelectCountryFocused();
        }
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (UpgradeTierCubit cubit) => cubit.state.status.isLoading,
    );
    final selectedCountry = context.select(
      (UpgradeTierCubit cubit) => cubit.state.selectedCountry,
    );
    final selectedCountryErrMsg = context.select(
      (UpgradeTierCubit cubit) => cubit.state.selectedCountryErrMsg,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.country),

        AppDropdownField.underlineBorder(
          items: ['Nigeria'],

          enabled: !isLoading,
          focusNode: _focusNode,
          filled: Config.filled,
          hintText: AppStrings.select,
          onChanged: (p0) => _debouncer.run(() => _cubit.onSelectCountry(p0)),
          initialValue: selectedCountry,
          errorText: selectedCountryErrMsg == '' ? null : selectedCountryErrMsg,
        ),
      ],
    );
  }
}
