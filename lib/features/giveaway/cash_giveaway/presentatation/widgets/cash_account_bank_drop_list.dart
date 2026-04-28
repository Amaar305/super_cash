import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashAccountBankDropList extends StatelessWidget {
  const CashAccountBankDropList({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CashGiveawayCubit cubit) =>
          cubit.state.status.isLoading || cubit.state.status.isValidated,
    );
    final banks = context.select(
      (CashGiveawayCubit element) => element.state.bankList,
    );
    final selectedBank = context.select(
      (CashGiveawayCubit element) => element.state.selectedBank,
    );
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDropdownSearchField(
          enable: !isLoading,
          items: banks.map((e) => e.bankName).toList(),
          label: 'Select Bank',
          hint: 'Select or search a bank',

          initialValue: selectedBank?.bankName,
          onChange: isLoading
              ? null
              : (value) {
                  if (value == null) return;

                  final bank = banks.firstWhere(
                    (element) => element.bankName == value,
                    // orElse: () => null,
                  );

                  context.read<CashGiveawayCubit>().onBankSelected(bank);
                },
        ),
      ],
    );
  }
}
