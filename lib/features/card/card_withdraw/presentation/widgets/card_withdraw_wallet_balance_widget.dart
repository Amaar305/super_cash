import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardWithdrawWalletBalanceWidget extends StatelessWidget {
  const CardWithdrawWalletBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = context.select(
      (CardWithdrawCubit cubit) => cubit.state.wallet,
    );
    return CardDetailContainer(
      text: 'Wallet Balance: ',
      text2: 'N${wallet.walletBalance}',
      color: AppColors.grey.withValues(alpha: 0.12),
    );
  }
}
