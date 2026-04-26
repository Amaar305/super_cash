import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayWinnersPage extends StatelessWidget {
  const GiveawayWinnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GiveawayWinnersCubit(
        getGiveawayWinnersUseCase: serviceLocator<GetGiveawayWinnersUseCase>(),
      ),
      child: GiveawayWinnersView(),
    );
  }
}

class GiveawayWinnersView extends StatelessWidget {
  const GiveawayWinnersView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Winners')),
      body: BlocBuilder<GiveawayWinnersCubit, GiveawayWinnersState>(
        builder: (context, state) {
          if (state.status.isInitial) {
            context.read<GiveawayWinnersCubit>().getGiveawayWinners();
            return const Center(child: CircularProgressIndicator());
          }

          return switch (state.status) {
            GiveawayWinnersStatus.loading => GiveawayWinnersLoading(),
            GiveawayWinnersStatus.success => GiveawayWinnersListView(
              winners: state.filteredWinners,
            ),
            GiveawayWinnersStatus.failure => GiveawayWinnersFailure(
              message: state.message,
              onTap: context.read<GiveawayWinnersCubit>().getGiveawayWinners,
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
