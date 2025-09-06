import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class TransferBankDropField extends StatefulWidget {
  const TransferBankDropField({super.key});

  @override
  State<TransferBankDropField> createState() => _TransferBankDropFieldState();
}

class _TransferBankDropFieldState extends State<TransferBankDropField> {
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
          _cubit.onSelectBankFocused();
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
      (TransferCubit cubit) => cubit.state.selectedBankErrorMsg,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.selectAvailableBank,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppDropdownField(
          items: ['Kano', 'Nigeria', 'Jigawa', 'Kano'],
          filled: Config.filled,
          enabled: !isLoading && bankDetail == null,
          focusNode: _focusNode,
          onChanged: (bank) => _debouncer.run(() => _cubit.onSelectBank(bank)),
          hintText: AppStrings.select,
          errorText: errorMsg == '' ? null : errorMsg,
        ),
      ],
    );
  }
}
