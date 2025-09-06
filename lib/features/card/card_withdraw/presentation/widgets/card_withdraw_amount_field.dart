import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../card_withdraw.dart';

class CardWithdrawAmountField extends StatefulWidget {
  const CardWithdrawAmountField({super.key});

  @override
  State<CardWithdrawAmountField> createState() =>
      _CardWithdrawAmountFieldState();
}

class _CardWithdrawAmountFieldState extends State<CardWithdrawAmountField> {
  late final CardWithdrawCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CardWithdrawCubit>();
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onAmountFocused();
        }
      });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CardWithdrawCubit cubit) => cubit.state.status.isLoading,
    );
    final amountErrorMsg = context.select(
      (CardWithdrawCubit cubit) => cubit.state.amount.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          'How much would you like to withdraw in \$ USD?',
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppTextField.underlineBorder(
          focusNode: _focusNode,
          prefixIcon: const Icon(
            Icons.money_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          hintText: AppStrings.enterAmount,
          filled: Config.filled,
          enabled: !isLoading,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          errorText: amountErrorMsg,
          onChanged: (p0) => _debouncer.run(() => _cubit.onAmountChanged(p0)),
        ),
      ],
    );
  }
}
