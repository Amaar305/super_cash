import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DataNetworkFilterChips extends StatelessWidget {
  const DataNetworkFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.select<DataGiveawayCubit, int>(
      (value) => value.state.selectedNetworkFilterIndex,
    );
    return GiveawayNetworkFilterChips(
      labels: ['All', 'MTN', 'Airtel', 'GLO', '9Mobile'],
      selectedIndex: selectedIndex,
      onIndexChanged: context.read<DataGiveawayCubit>().onFilterNetworkChanged,
    );
  }
}
