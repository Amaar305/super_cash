import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class ElectricityAmountField extends StatefulWidget {
  const ElectricityAmountField({super.key});

  @override
  State<ElectricityAmountField> createState() => _ElectricityAmountFieldState();
}

class _ElectricityAmountFieldState extends State<ElectricityAmountField> {
  late final ElectricityCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ElectricityCubit>();
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
    _focusNode.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ElectricityCubit c) => c.state.status.isLoading,
    );
    final amountErrorMsg = context.select(
      (ElectricityCubit c) => c.state.amount.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.enterAmount,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField.underlineBorder(
          enabled: !isLoading,
          focusNode: _focusNode,
          hintText: AppStrings.enterAmount,
          filled: Config.filled,
          prefixIcon: Icon(
            Icons.account_balance_wallet_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
          onChanged: (p0) => _debouncer.run(() => _cubit.onAmountChanged(p0)),
          errorText: amountErrorMsg,
        ),
      ],
    );
  }
}
