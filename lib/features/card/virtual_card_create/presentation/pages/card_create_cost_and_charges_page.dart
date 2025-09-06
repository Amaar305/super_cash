import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/card/card_repo/cubit/card_repo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../../../core/common/common.dart';
import '../../../card.dart';

class CardCreateCostAndChargesPage extends StatelessWidget {
  const CardCreateCostAndChargesPage({super.key, required this.cardCubit});

  final CreateVirtualCardCubit cardCubit;

  static route({required CreateVirtualCardCubit cardCubit}) =>
      MaterialPageRoute(
        builder: (context) =>
            CardCreateCostAndChargesPage(cardCubit: cardCubit),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cardCubit,
      child: CardCreateCostAndChargesView(),
    );
  }
}

class CardCreateCostAndChargesView extends StatelessWidget {
  const CardCreateCostAndChargesView({super.key});

  void _confirmAlertDialog(BuildContext context) => context.confirmAction(
    fn: () => Navigator.pop(context),
    title: AppStrings.goBackTitle,
    content: AppStrings.goBackDescrption,
    noText: AppStrings.cancel,
    yesText: AppStrings.goBack,
    yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        _confirmAlertDialog(context);
        return Future.value(false);
      },
      child: AppScaffold(
        appBar: AppBar(
          leading: AppLeadingAppBarWidget(
            onTap: () => _confirmAlertDialog(context),
          ),
          title: AppAppBarTitle(AppStrings.costAndCharges),
        ),
        body: BlocListener<CreateVirtualCardCubit, CreateVirtualCardState>(
          listenWhen: (previous, current) => current.status != previous.status,
          listener: (context, state) {
            if (state.status.isError && state.message.isNotEmpty) {
              openSnackbar(
                SnackbarMessage.error(title: state.message),
                clearIfQueue: true,
              );
            }
          },
          child: AppConstrainedScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                spacing: AppSpacing.xxlg,
                children: [
                  CardDollarRateWidget(),
                  CardCreateCostAndChargesDetails(),
                  CardWalletBalanceWidget(),
                  CardCreateButton(),
                  CardSupportedPlatforms(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardCreateCostAndChargesDetails extends StatelessWidget {
  const CardCreateCostAndChargesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final amount = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.amount.value,
    );

    final cardCreationFee = context.select(
      (CardRepoCubit cubit) => cubit.state.dollarRate?.cardCreationFee ?? 0,
    );
    final dollarRate = context.select(
      (CardRepoCubit cubit) => cubit.state.dollarRate?.dollarRate ?? 1,
    );
    String totalFee =
        '\$$amount ≈ ${calculateTotalFee(amount: amount, dollarRate: dollarRate, fee: cardCreationFee)}';
    String creationFundingAmount =
        '\$$amount ≈ ${convertAmount(amount, dollarRate)}';

    return Column(
      spacing: AppSpacing.sm,
      children: [
        // CardCreationFeeWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.sm,
              children: [
                cardTransactionDescText('Card Creation Cost'),
                cardTransactionDescText('Creation Funding Amount'),
                cardTransactionDescText('Total Fee'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: [
                cardTransactionDescSmallText(
                  '\$${(cardCreationFee / dollarRate).toStringAsFixed(0)} ≈ N$cardCreationFee',
                ),
                cardTransactionDescSmallText(creationFundingAmount),
                cardTransactionDescSmallText(totalFee),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CardCreationFeeWidget extends StatelessWidget {
  const CardCreationFeeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cardCreationFee = context.select(
      (CardRepoCubit cubit) => cubit.state.dollarRate?.cardCreationFee ?? 0,
    );
    final dollarRate = context.select(
      (CardRepoCubit cubit) => cubit.state.dollarRate?.dollarRate ?? 1,
    );

    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Creation Fee',
          style: poppinsTextStyle(
            fontSize: AppSpacing.md - 1,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md + 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  cardTransactionDescText('Card Creation Cost'),
                  cardTransactionDescText('Card Limits'),
                ],
              ),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardTransactionDescSmallText(
                    '\$${(cardCreationFee / dollarRate).toStringAsFixed(0)} ≈ N$cardCreationFee',
                  ),
                  cardTransactionDescSmallText(
                    '\$${(cardCreationFee / dollarRate).toStringAsFixed(0)} ≈ N$cardCreationFee',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
