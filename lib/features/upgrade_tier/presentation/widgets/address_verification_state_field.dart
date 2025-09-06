import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:super_cash/features/upgrade_tier/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class AddressVerificationStateField extends StatefulWidget {
  const AddressVerificationStateField({super.key});

  @override
  State<AddressVerificationStateField> createState() =>
      _AddressVerificationStateFieldState();
}

class _AddressVerificationStateFieldState
    extends State<AddressVerificationStateField> {
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
          _cubit.onSelectStateFocused();
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
    final selectedState = context.select(
      (UpgradeTierCubit cubit) => cubit.state.selectedState,
    );
    final selectedStateErrMsg = context.select(
      (UpgradeTierCubit cubit) => cubit.state.selectedStateErrMsg,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.state),
        AppDropdownField.underlineBorder(
          items: states.map((state) => state.name).toList(),
          enabled: !isLoading,
          focusNode: _focusNode,
          filled: Config.filled,
          hintText: AppStrings.select,
          onChanged: (p0) => _debouncer.run(() => _cubit.onSelectState(p0)),
          initialValue: selectedState,
          errorText: selectedStateErrMsg == '' ? null : selectedStateErrMsg,
        ),
      ],
    );
  }
}
