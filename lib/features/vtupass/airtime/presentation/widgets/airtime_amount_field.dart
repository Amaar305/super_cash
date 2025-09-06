import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../airtime.dart';

class AirtimeAmountField extends StatefulWidget {
  const AirtimeAmountField({super.key});

  @override
  State<AirtimeAmountField> createState() => _AirtimeAmountFieldState();
}

class _AirtimeAmountFieldState extends State<AirtimeAmountField> {
  late final AirtimeCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;
  late TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AirtimeCubit>();
    _debouncer = Debouncer();
    _editingController = TextEditingController();
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
      (AirtimeCubit cubit) => cubit.state.status.isLoading,
    );
    final amountErrorMessage = context.select(
      (AirtimeCubit cubit) => cubit.state.amount.errorMessage,
    );
    final amountValue = context.select(
      (AirtimeCubit cubit) => cubit.state.amount.value,
    );
    _editingController.text = amountValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.enterAmount,
          style: poppinsTextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppTextField.underlineBorder(
          hintText: AppStrings.enterAmount,
          // filled: Config.filled,
          prefixIcon: Icon(
            Icons.account_balance_wallet_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          focusNode: _focusNode,
          enabled: !isLoading,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          onChanged: (v) => _debouncer.run(() => _cubit.onAmountChanged(v)),
          textController: _editingController,
          errorText: amountErrorMessage,
        ),
      ],
    );
  }
}
