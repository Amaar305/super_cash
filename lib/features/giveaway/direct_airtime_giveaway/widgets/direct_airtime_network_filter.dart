import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DirectAirtimeNetworkFilter extends StatelessWidget {
  const DirectAirtimeNetworkFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNetworkIndex = context
        .select<DirectAirtimeGiveawayCubit, int>(
          (value) => value.state.selectedNetworkFilterIndex,
        );
    return GiveawayNetworkFilterChips(
      labels: ['All', 'MTN', 'Airtel', 'GLO', '9Mobile'],
      selectedIndex: selectedNetworkIndex,
      onIndexChanged: context
          .read<DirectAirtimeGiveawayCubit>()
          .onFilterNetworkChanged,
    );
  }
}
