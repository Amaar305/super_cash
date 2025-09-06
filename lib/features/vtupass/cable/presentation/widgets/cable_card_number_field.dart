import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class CableCardNumberField extends StatefulWidget {
  const CableCardNumberField({super.key});

  @override
  State<CableCardNumberField> createState() => _CableCardNumberFieldState();
}

class _CableCardNumberFieldState extends State<CableCardNumberField> {
  late final CableCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CableCubit>();
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onDecoderFocused();
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
      (CableCubit cubit) => cubit.state.status.isLoading,
    );
    final amountErrorMessage = context.select(
      (CableCubit cubit) => cubit.state.cardNumber.errorMessage,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(AppStrings.cableNumber, style: context.bodySmall),
        AppTextField.underlineBorder(
          prefixIcon: Icon(
            Icons.account_balance_wallet_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          hintText: AppStrings.cableNumber,
          filled: Config.filled,
          focusNode: _focusNode,
          enabled: !isLoading,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          onChanged: (v) => _debouncer.run(() => _cubit.onDecoderChanged(v)),
          errorText: amountErrorMessage,
          errorMaxLines: 3,
        ),
      ],
    );
  }
}
