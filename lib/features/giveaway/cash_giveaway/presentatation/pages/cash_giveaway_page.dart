import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashGiveawayPage extends StatelessWidget {
  const CashGiveawayPage({super.key, required this.giveawayTypeId});
  final String giveawayTypeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CashGiveawayCubit(
              addCashAccountDetailsUseCase: serviceLocator(),
              claimCashGiveawayUseCase: serviceLocator(),
              getCashGiveawaysUseCase: serviceLocator(),
              giveawayTypeId: giveawayTypeId,
              fetchBankListUseCase: serviceLocator(),
              validateBankUseCase: serviceLocator(),
            )
            ..getCashGiveaways()
            ..fetchBankList(),
      child: CashGiveawayView(),
    );
  }
}

class CashGiveawayView extends StatelessWidget {
  const CashGiveawayView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Cash Giveaway')),
      body: RefreshIndicator.adaptive(
        onRefresh: context.read<CashGiveawayCubit>().getCashGiveaways,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: BlocListener<CashGiveawayCubit, CashGiveawayState>(
            listenWhen: (p, c) => p.status != c.status,
            listener: (context, state) {
              if (state.status.isLoading) {
                showLoadingOverlay(context);
              } else {
                hideLoadingOverlay();
              }
              if (state.status.isFailure && state.message.isNotEmpty) {
                openSnackbar(SnackbarMessage.error(title: state.message));
              }
            },
            child: Column(
              children: [
                CashGiveawayHeader(),
                Expanded(child: CashGiveawayListView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
