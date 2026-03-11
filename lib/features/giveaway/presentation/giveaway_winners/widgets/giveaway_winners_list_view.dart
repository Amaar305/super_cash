import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayWinnersListView extends StatelessWidget {
  const GiveawayWinnersListView({super.key, required this.winners});
  final List<GiveawayWinner> winners;

  @override
  Widget build(BuildContext context) {
    final child = winners.isEmpty
        ? AppEmptyState(title: 'No winners yet!.')
        : Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Gap.v(AppSpacing.md),
              padding: EdgeInsets.all(AppSpacing.lg),
              itemCount: winners.length,
              itemBuilder: (context, index) =>
                  GiveawayWinnerCard(winner: winners[index]),
            ),
          );
    return Column(
      children: [
        GiveawayFilterSection(
          types: ['All Categories', 'Airtime', 'Data'],
          onChanged: context.read<GiveawayWinnersCubit>().onFilterChanged,
        ),
        child,
      ],
    );
  }
}
