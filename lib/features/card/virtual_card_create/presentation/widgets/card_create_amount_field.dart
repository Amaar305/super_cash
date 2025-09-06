import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class CardCreateAmountField extends StatefulWidget {
  const CardCreateAmountField({super.key});

  @override
  State<CardCreateAmountField> createState() => _CardCreateAmountFieldState();
}

class _CardCreateAmountFieldState extends State<CardCreateAmountField> {
  late final CreateVirtualCardCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CreateVirtualCardCubit>();
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
      (CreateVirtualCardCubit cubit) => cubit.state.status.isLoading,
    );
    final amountErrorMessage = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.amount.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        FieldLabelTitle(AppStrings.enterAmountToFundCard),
        AppTextField.underlineBorder(
          hintText: AppStrings.enterAmount,
          filled: Config.filled,
          focusNode: _focusNode,
          enabled: !isLoading,
          prefixIcon: AppPrefixIcon(Icons.money_outlined),
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          onChanged: (v) => _debouncer.run(() => _cubit.onAmountChanged(v)),
          errorText: amountErrorMessage,
        ),
      ],
    );
  }
}
