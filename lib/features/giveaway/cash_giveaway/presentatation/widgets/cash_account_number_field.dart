import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashAccountNumberField extends StatefulWidget {
  const CashAccountNumberField({super.key});

  @override
  State<CashAccountNumberField> createState() => _CashAccountNumberFieldState();
}

class _CashAccountNumberFieldState extends State<CashAccountNumberField> {
  late final TextEditingController _controller;
  late final CashGiveawayCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CashGiveawayCubit>();
    _controller = TextEditingController(text: _cubit.state.accountNumber.value)
      ..addListener(_onAccountNumberChanged);
    _focusNode = FocusNode()..addListener(_onAccountNumberfocused);
    _debouncer = Debouncer();
  }

  @override
  void didUpdateWidget(CashAccountNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_cubit.state.accountNumber.value != _controller.text) {
      _controller.text = _cubit.state.accountNumber.value;
    }
  }

  void _onAccountNumberChanged() {
    _debouncer.run(() {
      _cubit.onAccountNumberChanged(_controller.text);
    });
  }

  void _onAccountNumberfocused() {
    if (!_focusNode.hasFocus) {
      _cubit.onAccountNumberFocused();
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onAccountNumberChanged)
      ..dispose();
    _focusNode
      ..removeListener(_onAccountNumberfocused)
      ..dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountNumberErrorMessage = context.select(
      (CashGiveawayCubit cubit) => cubit.state.accountNumber.errorMessage,
    );
    final isLoading = context.select(
      (CashGiveawayCubit cubit) =>
          cubit.state.status.isLoading || cubit.state.status.isValidated,
    );
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabelTitle('Select Bank'),
        AppTextField.underlineBorder(
          hintText: 'Account Number',
          focusNode: _focusNode,
          prefixIcon: const Icon(
            Icons.person_outline,
            size: 24,
            color: AppColors.grey,
          ),
          textInputType: TextInputType.name,
          textInputAction: TextInputAction.done,
          enabled: !isLoading,
          textController: _controller,
          errorText: accountNumberErrorMessage,
        ),
      ],
    );
  }
}
