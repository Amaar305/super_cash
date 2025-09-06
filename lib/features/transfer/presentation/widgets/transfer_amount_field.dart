import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class TransferAmountField extends StatefulWidget {
  const TransferAmountField({super.key});

  @override
  State<TransferAmountField> createState() => _TransferAmountFieldState();
}

class _TransferAmountFieldState extends State<TransferAmountField> {
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;
  late final TransferCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<TransferCubit>();
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
      (TransferCubit cubit) => cubit.state.status.isLoading,
    );
    final errorMsg = context.select(
      (TransferCubit cubit) => cubit.state.amount.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.enterAmountToTransfer,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField(
          filled: Config.filled,
          enabled: !isLoading,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.number,
          focusNode: _focusNode,
          onChanged: (amt) => _debouncer.run(() => _cubit.onAmountChanged(amt)),
          hintText: '0.0',
          errorText: errorMsg,
        ),
      ],
    );
  }
}
