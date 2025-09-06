import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:super_cash/core/app_strings/app_string.dart';

import '../../../card.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({super.key, required this.cardId});
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardDetailCubit(
        cardId: cardId,
        cardDetailsUseCase: serviceLocator(),
        freezeCardUseCase: serviceLocator(),
      )..fetchCardDetails(),
      child: CardDetailsView(cardId: cardId),
    );
  }
}

class CardDetailsView extends StatelessWidget {
  const CardDetailsView({super.key, required this.cardId});
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: AppLeadingAppBarWidget(onTap: context.pop),
        title: AppAppBarTitle(AppStrings.cardDetails),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<CardDetailCubit>().fetchCardDetails(forceRefresh: true);
        },
        child: AppConstrainedScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: CardDetailsBody(cardId: cardId),
          ),
        ),
      ),
    );
  }
}

class CardDetailsBody extends StatelessWidget {
  const CardDetailsBody({super.key, required this.cardId});

  final String cardId;

  @override
  Widget build(BuildContext context) {
    final cardDetails = context.select(
      (CardDetailCubit cubit) => cubit.state.cardDetails,
    );
    void onChangeCardPin() {
      context.push(
        AppRoutes.virtualCardChangePin,
        extra: {'card_id': cardId, 'card_details': cardDetails},
      );
    }

    void onCalculateTransactionTapped() {
      Navigator.push(context, CardTransactionCalculatorPage.route());
    }

    return BlocListener<CardDetailCubit, CardDetailState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
          return;
        }
      },
      child: Column(
        children: [
          VirtaulCardDetails(cardDetails: cardDetails),
          Gap.v(AppSpacing.lg),
          // CardDetailNotes(),
          // Gap.v(AppSpacing.lg),
          CardDetailsSection(),
          Gap.v(AppSpacing.md),
          CardBillingAddressSection(),
          Gap.v(AppSpacing.md),
          CardQuickActionTile(
            leading: Assets.icons.iconWallet.svg(),
            title: AppStrings.calculateTransactionFee,
            onTap: onCalculateTransactionTapped,
          ),
          CardQuickActionTile(
            leading: Assets.icons.iconSettingEye.svg(),
            title: AppStrings.changeCardPin,
            onTap: onChangeCardPin,
          ),
          FreezeCardTileWidget(cardId: cardId),
        ],
      ),
    );
  }
}
