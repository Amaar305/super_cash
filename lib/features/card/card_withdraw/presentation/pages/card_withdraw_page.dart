import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/card/card_repo/cubit/card_repo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../../../../../core/common/common.dart';
import '../../../card.dart';

class CardWithdrawPage extends StatelessWidget {
  const CardWithdrawPage({super.key, required this.cardId});
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardWithdrawCubit(
        cardId: cardId,
        walletBalanceUseCase: serviceLocator(),
        withdrawFundUseCase: serviceLocator(),
      )..onFetchWalletBalance(),
      child: CardWithdrawView(cardId: cardId),
    );
  }
}

class CardWithdrawView extends StatelessWidget {
  const CardWithdrawView({super.key, required this.cardId});
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.withdraw),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            spacing: AppSpacing.xlg,
            children: [
              CardDollarRateWidget(),
              CardWithdrawCoolDownText(),
              SizedBox.shrink(),
              CardWithdrawForm(),
              SizedBox.shrink(),
              CardWithdrawTransactionFeeSection(),
              CardWithdrawWalletBalanceWidget(),
              CardWithdrawButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class CardWithdrawTransactionFeeSection extends StatelessWidget {
  const CardWithdrawTransactionFeeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final amount = context.select(
      (CardWithdrawCubit cubit) => cubit.state.amount.value,
    );

    final dollarRate = context.select(
      (CardRepoCubit cubit) => cubit.state.dollarRate?.dollarRate ?? 0,
    );
    String creditedAmount = convertAmount(amount, dollarRate);
    String amountW = '\$$amount ≈ ${convertAmount(amount, dollarRate)}';
    return Column(
      spacing: AppSpacing.lg,
      children: [
        Text(
          AppStrings.transactionFee,
          style: poppinsTextStyle(
            fontWeight: AppFontWeight.semiBold,
            fontSize: AppSpacing.md,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: [
                cardTransactionDescText('Amount'),
                cardTransactionDescText('Total Charged'),
                cardTransactionDescText('Amount to be credited to your wallet'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: AppSpacing.md + 2,
              children: [
                cardTransactionDescSmallText(amountW),
                cardTransactionDescSmallText('Free'),
                cardTransactionDescSmallText(creditedAmount),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
