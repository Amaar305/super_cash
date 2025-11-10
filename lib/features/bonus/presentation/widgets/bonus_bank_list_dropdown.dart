import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';

class BonusBankListDropdown extends StatelessWidget {
  const BonusBankListDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (BonusCubit cubit) =>
          cubit.state.status.isLoading || cubit.state.status.isValidated,
    );
    final banks = context.select(
      (BonusCubit element) => element.state.bankList,
    );
    final selectedBank = context.select(
      (BonusCubit element) => element.state.selectedBank,
    );
    return AppDropdownSearchField(
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

              context.read<BonusCubit>().onBankSelected(bank);
            },
    );
  }
}
