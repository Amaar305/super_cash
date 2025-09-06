import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class TransferAccountNumberField extends StatefulWidget {
  const TransferAccountNumberField({super.key});

  @override
  State<TransferAccountNumberField> createState() =>
      _TransferAccountNumberFieldState();
}

class _TransferAccountNumberFieldState
    extends State<TransferAccountNumberField> {
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
          _cubit.onAccountNumberFocused();
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
    final bankDetail = context.select(
      (TransferCubit cubit) => cubit.state.bankDetail,
    );
    final errorMsg = context.select(
      (TransferCubit cubit) => cubit.state.account.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.enterAccountNumber,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField(
          filled: Config.filled,
          enabled: !isLoading && bankDetail == null,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          focusNode: _focusNode,
          onChanged: (acc) =>
              _debouncer.run(() => _cubit.onAccountNumberChanged(acc)),
          hintText: '0000000000',
          errorText: errorMsg,
        ),
      ],
    );
  }
}
