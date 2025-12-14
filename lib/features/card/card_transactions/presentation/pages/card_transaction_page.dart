import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:super_cash/core/app_strings/app_string.dart';

import '../presentation.dart';

class CardTransactionPage extends StatelessWidget {
  const CardTransactionPage({super.key, required this.cardId});
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardTransactionsCubit(
        cardId: cardId,
        fetchCardTransactionsUseCase: serviceLocator(),
      )..fetchInitialTransactions(),
      child: CardTransactionView(cardId: cardId),
    );
  }
}

class CardTransactionView extends StatelessWidget {
  const CardTransactionView({super.key, required this.cardId});
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.transaction),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.lg,
          children: [
            CardTransactionSearchField(),
            // CardTransactionFilterButton()
            
            CardTransactionsBody(),
            // CardTransactionsFooter(),
          ],
        ),
      ),
    );
  }
}

class CardTransactionsFooter extends StatelessWidget {
  const CardTransactionsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      color: Color(0xFFF8FAFC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('data')],
      ),
    );
  }
}
