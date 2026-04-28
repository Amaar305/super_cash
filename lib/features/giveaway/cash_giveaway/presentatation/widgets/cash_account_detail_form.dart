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
      spacing: 20,
      children: [
        Text(
          'Account Information',
          style: poppinsTextStyle(fontWeight: AppFontWeight.bold, fontSize: 20),
        ),
        Gap.v(AppSpacing.xs),
        CashAccountBankDropList(),
        CashAccountNumberField(),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: context.read<CashGiveawayCubit>().validateBank,
            child: Text(
              'VERIFY ACCOUNT',
              style: poppinsTextStyle(
                fontWeight: AppFontWeight.bold,
                color: Color(0xFF006E2F),
              ),
            ),
          ),
        ),

        CashValidatedAccount(),
        _AddBUtton(cashId: cashItem.id),
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
