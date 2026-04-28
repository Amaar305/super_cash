import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DirectAirtimeGiveawayListView extends StatelessWidget {
  const DirectAirtimeGiveawayListView({super.key});

  @override
  Widget build(BuildContext context) {
    final airtimes = context
        .select<DirectAirtimeGiveawayCubit, List<DirectAirtimeModel>>(
          (value) => value.state.filteredAirtimes,
        );
    if (airtimes.isEmpty) {
      return AppEmptyState(
        title: 'No available airtimes',
        icon: Icons.phone_iphone_outlined,
        action: TextButton.icon(
          onPressed: context.read<DirectAirtimeGiveawayCubit>().getAirtimes,
          label: Text('Refresh'),
          icon: Icon(Icons.refresh),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: airtimes.length,
        itemBuilder: (context, index) {
          final item = airtimes[index];
          return DataGiveawayCard(
            isAirtime: true,
            dataName: item.airtimeName,
            dataSize: '${item.fixedAmount} Naira',
            network: item.network,
            dataQuantity: item.amountQuantity,
            dataQuantityRemaining: item.amountQuantityRemaining,
            isAvailable: item.isAvailable,
            onClaimed: () async {
              final cubit = context.read<DirectAirtimeGiveawayCubit>();
              cubit.claimDirectAirtime(
                item.id,
                onClaimed: (airtime) => _onClaimedGiveaway(
                  airtime: airtime,
                  context: context,
                  cubit: cubit,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _onClaimedGiveaway({
    required airtime,
    required BuildContext context,
    required DirectAirtimeGiveawayCubit cubit,
  }) async {
    final success = await showModalBottomSheet<UserDirectAirtimePhoneModel?>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      showDragHandle: false,
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: DirectAirtimeGiveawaySheet(giveaway: airtime),
        );
      },
    );

    if (success != null && context.mounted) {
      context.showConfirmationBottomSheet(
        title: 'Congratulation!',
        description:
            'Your airtime has been successfully sent to ${success.phoneNumber}. Check your balance to confirm.',
        okText: 'Done',
      );
    }
  }
}
