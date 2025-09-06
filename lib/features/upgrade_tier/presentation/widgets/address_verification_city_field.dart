import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/upgrade_tier/upgrade_tier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../core/common/common.dart';

class AddressVerificationCityField extends StatefulWidget {
  const AddressVerificationCityField({super.key});

  @override
  State<AddressVerificationCityField> createState() =>
      _AddressVerificationCityFieldState();
}

class _AddressVerificationCityFieldState
    extends State<AddressVerificationCityField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    final city = _cubit.state.city;
    _controller = TextEditingController(text: city.value)
      ..addListener(_onTextChanged);

    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onCityUnfocused();
        }
      });
  }

  @override
  void didUpdateWidget(AddressVerificationCityField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final city = _cubit.state.city;

    if (_controller.text != city.value) {
      _controller.text = city.value;
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
      (UpgradeTierCubit cubit) => cubit.state.status.isLoading,
    );

    final cityErrMsg = context.select(
      (UpgradeTierCubit cubit) => cubit.state.city.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.city),
        AppTextField.underlineBorder(
          focusNode: _focusNode,
          enabled: !isLoading,
          prefixIcon: AppPrefixIcon(Icons.place_outlined),
          filled: Config.filled,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          hintText: "Enter ${AppStrings.city.toLowerCase()}",
          textController: _controller,
          errorText: cityErrMsg,
        ),
      ],
    );
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onCityChanged(_controller.text.trim()));
  }
}
