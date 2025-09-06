import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/app_prefix_icon.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/upgrade_tier/presentation/cubit/upgrade_tier_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class AddressVerificationHouseNumberField extends StatefulWidget {
  const AddressVerificationHouseNumberField({super.key});

  @override
  State<AddressVerificationHouseNumberField> createState() =>
      _AddressVerificationHouseNumberFieldState();
}

class _AddressVerificationHouseNumberFieldState
    extends State<AddressVerificationHouseNumberField> {
  late final UpgradeTierCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
    final houseNumber = _cubit.state.houseNumber;
    _controller = TextEditingController(text: houseNumber.value)
      ..addListener(_onTextChanged);

    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onHouseNumberUnfocused();
        }
      });
  }

  @override
  void didUpdateWidget(AddressVerificationHouseNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final houseNumber = _cubit.state.houseNumber;

    if (_controller.text != houseNumber.value) {
      _controller.text = houseNumber.value;
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
    final houseNumberErrMsg = context.select(
      (UpgradeTierCubit element) => element.state.houseNumber.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle(AppStrings.houseNo),
        AppTextField.underlineBorder(
          prefixIcon: AppPrefixIcon(Icons.numbers_outlined),
          enabled: !isLoading,
          focusNode: _focusNode,
          filled: Config.filled,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
          hintText: "Enter ${AppStrings.houseNo.toLowerCase()}",
          textController: _controller,
          errorText: houseNumberErrMsg,
        ),
      ],
    );
  }

  void _onTextChanged() {
    _debouncer.run(() => _cubit.onHouseNumberChanged(_controller.text.trim()));
  }
}
