import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';

class BonusAmountField extends StatefulWidget {
  const BonusAmountField({super.key});

  @override
  State<BonusAmountField> createState() => _BonusAmountFieldState();
}

class _BonusAmountFieldState extends State<BonusAmountField> {
  late final TextEditingController _controller;
  late final BonusCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<BonusCubit>();
    _controller = TextEditingController(text: _cubit.state.amount.value)
      ..addListener(_onAmountChanged);
    _focusNode = FocusNode()..addListener(_onAmountfocused);
    _debouncer = Debouncer();
  }

  @override
  void didUpdateWidget(BonusAmountField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_cubit.state.amount.value != _controller.text) {
      _controller.text = _cubit.state.amount.value;
    }
  }

  void _onAmountChanged() {
    _debouncer.run(() {
      _cubit.onAmountChanged(_controller.text);
    });
  }

  void _onAmountfocused() {
    if (!_focusNode.hasFocus) {
      _cubit.onAmountFocused();
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onAmountChanged)
      ..dispose();
    _focusNode
      ..removeListener(_onAmountfocused)
      ..dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amountErrorMessage = context.select(
      (BonusCubit cubit) => cubit.state.amount.errorMessage,
    );
    final isLoading = context.select(
      (BonusCubit cubit) => cubit.state.status.isLoading,
    );
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.enterAmountToTransfer, style: poppinsTextStyle()),
        AppTextField.underlineBorder(
          hintText: AppStrings.enterAmount,
          focusNode: _focusNode,
          prefixIcon: const Icon(
            Icons.wallet_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          filled: Config.filled,
          enabled: !isLoading,
          textController: _controller,
          errorText: amountErrorMessage,
        ),
      ],
    );
  }
}
