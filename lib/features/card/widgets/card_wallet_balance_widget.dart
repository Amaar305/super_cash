import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardWalletBalanceWidget extends StatelessWidget {
  const CardWalletBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final walletBalnce = context.select(
      (AppCubit bloc) => bloc.state.user?.wallet.walletBalance,
    );

    return CardDetailContainer(
      text: 'Wallet Balance: ',
      text2: 'N$walletBalnce',
      color: AppColors.grey.withValues(alpha: 0.12),
    );
  }
}
