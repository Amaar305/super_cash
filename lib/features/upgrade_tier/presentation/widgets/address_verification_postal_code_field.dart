import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/upgrade_tier/upgrade_tier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../core/common/common.dart';

class AddressVerificationPostalCodeField extends StatefulWidget {
  const AddressVerificationPostalCodeField({super.key});

  @override
  State<AddressVerificationPostalCodeField> createState() =>
      _AddressVerificationPostalCodeFieldState();
}

class _AddressVerificationPostalCodeFieldState
    extends State<AddressVerificationPostalCodeField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    final postalCode = _cubit.state.postalCode;
    _controller = TextEditingController(text: postalCode.value)
      ..addListener(_onTextChanged);

    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onPostalCodeUnfocused();
        }
      });
  }

  @override
  void didUpdateWidget(AddressVerificationPostalCodeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final postalCode = _cubit.state.postalCode;

    if (_controller.text != postalCode.value) {
      _controller.text = postalCode.value;
    }
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (UpgradeTierCubit element) => element.state.status.isLoading,
    );
    final postalCodeErrMsg = context.select(
      (UpgradeTierCubit element) => element.state.postalCode.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.postalCode),
        AppTextField.underlineBorder(
          filled: Config.filled,
          enabled: !isLoading,
          prefixIcon: AppPrefixIcon(Icons.local_post_office_outlined),
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          autofillHints: const [AutofillHints.postalCode],
          hintText: "Enter ${AppStrings.postalCode.toLowerCase()}",
          textController: _controller,
          errorText: postalCodeErrMsg,
        ),
      ],
    );
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onPostalCodeChanged(_controller.text.trim()));
  }
}
