import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/card/card_repo/cubit/card_repo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../card.dart';

class FundCardPage extends StatelessWidget {
  const FundCardPage({super.key, required this.cardId});
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FundCardCubit(cardId: cardId, fundCardUseCase: serviceLocator()),
      child: FundCardView(cardId: cardId),
    );
  }
}

class FundCardView extends StatelessWidget {
  const FundCardView({super.key, required this.cardId});

  final String cardId;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: AppLeadingAppBarWidget(onTap: context.pop),
        title: AppAppBarTitle(AppStrings.fundCard),
      ),
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            spacing: AppSpacing.xlg,
            children: [
              CardDollarRateWidget(),
              FundCardCoolDownText(),
              SizedBox.shrink(),
              FundCardForm(),
              SizedBox.shrink(),
              FundCardTransactionFeeSection(),
              CardWalletBalanceWidget(),
              FundCardButton(),
              CardSupportedPlatforms(),
            ],
          ),
        ),
      ),
    );
  }
}

class FundCardTransactionFeeSection extends StatelessWidget {
  const FundCardTransactionFeeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final amount = context.select(
      (FundCardCubit cubit) => cubit.state.amount.value,
    );
    final cardTransactionFee = context.select(
      (CardRepoCubit cubit) => cubit.state.dollarRate?.cardTransactionFee ?? 0,
    );
    final dollarRate = context.select(
      (CardRepoCubit cubit) => cubit.state.dollarRate?.dollarRate ?? 0,
    );

    final totalCharge = calculateTotalFee(
      amount: amount,
      dollarRate: dollarRate,
      fee: cardTransactionFee,
    );
    final amountInNaira = convertAmount(amount, dollarRate);
    final deductedAmount = calculateTotalFee(
      amount: amount,
      dollarRate: dollarRate,
      fee: cardTransactionFee,
    );
    return Column(
      spacing: AppSpacing.lg,
      children: [
        Text(
          AppStrings.transactionFee,
          style: TextStyle(
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
                _buildText('Amount'),
                _buildText('Transaction Fee'),
                _buildText('Total Charged'),
                _buildText('Amount to be deducted from your wallet'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: AppSpacing.md + 2,
              children: [
                _buildSmallText('\$$amount ≈ $amountInNaira'),
                _buildSmallText('N$cardTransactionFee'),
                _buildSmallText('\$$amount ≈ $totalCharge'),
                _buildSmallText(deductedAmount),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Text _buildSmallText(String text) {
    return Text(
      text,
      style: poppinsTextStyle(
        fontSize: AppSpacing.md - 2,
        fontWeight: AppFontWeight.regular,
      ),
    );
  }

  Text _buildText(String text) {
    return Text(
      text,
      style: poppinsTextStyle(
        fontSize: AppSpacing.md,
        fontWeight: AppFontWeight.medium,
      ),
    );
  }
}
