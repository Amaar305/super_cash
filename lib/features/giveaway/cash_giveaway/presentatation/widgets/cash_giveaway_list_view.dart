import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashGiveawayListView extends StatelessWidget {
  const CashGiveawayListView({super.key});

  @override
  Widget build(BuildContext context) {
    final giveaways = context.select(
      (CashGiveawayCubit element) => element.state.giveaways,
    );
    if (giveaways.isEmpty) {
      return AppEmptyState(
        title: 'No available products',
        icon: Icons.production_quantity_limits_outlined,
        action: TextButton.icon(
          onPressed: context.read<CashGiveawayCubit>().getCashGiveaways,
          label: Text('Refresh'),
          icon: Icon(Icons.refresh),
        ),
      );
    }
    return ListView.separated(
      separatorBuilder: (context, index) => Gap.v(8),
      itemCount: giveaways.length,
      itemBuilder: (context, index) {
        final item = giveaways[index];
        return CashGiveawayCard(
          cash: item,
          onClaimed: (cashItem) {
            final cubit = context.read<CashGiveawayCubit>();

            cubit.claimGiveaway(
              cashItem.id,
              onClaimed: (cash) async {
                final success =
                    await showModalBottomSheet<UserCashAccountDetailModel?>(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: false,
                      enableDrag: false,
                      showDragHandle: false,
                      builder: (context) {
                        return BlocProvider.value(
                          value: cubit,
                          child: AddCashAccountDetailSheet(cashItem: cashItem),
                        );
                      },
                    );
                if (success != null && context.mounted) {
                  context.showConfirmationBottomSheet(
                    title: 'Your account details have been submitted.',
                    okText: 'Done',
                    description:
                        'We will send ${cashItem.amountFixed} to '
                        '${success.accountName} (${success.accountNumber}) '
                        'at ${success.bankName}.',
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
