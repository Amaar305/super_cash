import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashAccountDetailForm extends StatelessWidget {
  const CashAccountDetailForm({super.key, required this.cashItem});
  final CashGiveawayItem cashItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text(
          'Account Information',
          style: poppinsTextStyle(fontWeight: AppFontWeight.bold, fontSize: 16),
        ),
        Gap.v(AppSpacing.xs),
        CashAccountBankDropList(),
        CashAccountNumberField(),

        CashValidatedAccount(),
        _AddBUtton(cashId: cashItem.id),
        Gap.v(AppSpacing.lg),
      ],
    );
  }
}

class _AddBUtton extends StatelessWidget {
  const _AddBUtton({required this.cashId});
  final String cashId;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CashGiveawayCubit element) => element.state.status.isLoading,
    );
    final isValidated = context.select<CashGiveawayCubit, bool>(
      (value) => value.state.status.isValidated,
    );
    if (!isValidated) {
      return PrimaryButton(
        isLoading: isLoading,
        label: 'Verify Account',
        onPressed: () {
          context.read<CashGiveawayCubit>().validateBank();
        },
      );
    }
    return PrimaryButton(
      isLoading: isLoading,
      label: 'Confirm Withdraw',
      onPressed: () {
        context.read<CashGiveawayCubit>().addCashAccountDetails(
          cashId,
          onAdded: (account) => context.pop(account),
        );
      },
    );
  }
}
