import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class FundCardAmountField extends StatefulWidget {
  const FundCardAmountField({super.key});

  @override
  State<FundCardAmountField> createState() => _FundCardAmountFieldState();
}

class _FundCardAmountFieldState extends State<FundCardAmountField> {
  late final FundCardCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FundCardCubit>();
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
      (FundCardCubit cubit) => cubit.state.status.isLoading,
    );
    final amountErrorMsg = context.select(
      (FundCardCubit cubit) => cubit.state.amount.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          'How much would you like to fund in \$ USD?',
          style: poppinsTextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppTextField.underlineBorder(
          prefixIcon: const Icon(
            Icons.money_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          focusNode: _focusNode,
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
