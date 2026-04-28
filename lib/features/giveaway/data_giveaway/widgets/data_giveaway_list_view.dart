import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DataGiveawayListView extends StatelessWidget {
  const DataGiveawayListView({super.key});

  @override
  Widget build(BuildContext context) {
    final giveaways = context.select(
      (DataGiveawayCubit element) => element.state.filteredPlans,
    );
    if (giveaways.isEmpty) {
      return AppEmptyState(
        title: 'No available data plans',
        icon: Icons.phone_iphone_outlined,
        action: TextButton.icon(
          onPressed: context.read<DataGiveawayCubit>().getPlans,
          label: Text('Refresh'),
          icon: Icon(Icons.refresh),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: giveaways.length,
        itemBuilder: (context, index) {
          final giveaway = giveaways[index];
          return DataGiveawayCard(
            dataName: giveaway.dataName,
            dataSize: giveaway.dataSize,
            network: giveaway.network,
            dataQuantity: giveaway.dataQuantity,
            dataQuantityRemaining: giveaway.dataQuantityRemaining,
            isAvailable: giveaway.isAvailable,
            onClaimed: () async {
              final cubit = context.read<DataGiveawayCubit>();
              final succes = await showModalBottomSheet<DataGiveawayItem?>(
                context: context,
                isScrollControlled: true,
                isDismissible: false,
                enableDrag: false,
                showDragHandle: false,
                builder: (context) {
                  return BlocProvider.value(
                    value: cubit,
                    child: DataGiveawayClaimSheet(dataGiveawayItem: giveaway),
                  );
                },
              );
              if (succes != null && context.mounted) {
                context.showConfirmationBottomSheet(
                  title: 'Your data has been successfully sent..',
                  okText: 'Done',
                );
              }
            },
          );
        },
      ),
    );
  }
}
