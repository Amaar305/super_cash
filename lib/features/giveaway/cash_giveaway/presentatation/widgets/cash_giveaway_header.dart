import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import 'package:super_cash/features/giveaway/giveaway.dart';

class CashGiveawayHeader extends StatelessWidget {
  const CashGiveawayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((CashGiveawayCubit c) => c.state);

    return Row(
      spacing: AppSpacing.lg,
      children: [
        Expanded(
          child: GiveawayAnalyticsHeaderItem(
            title: 'TOTAL PRIZE POOL',
            icon: Icons.monetization_on,
            subtitle: '₦${state.totalCash.planDisplayAmount}',
            footerTitle: 'Across all active drops',
          ),
        ),
        Expanded(
          child: GiveawayAnalyticsHeaderItem(
            title: 'AVAILABLE TO CLAIM',
            icon: Icons.wallet_outlined,
            iconColor: Color(0xff006E2F),
            subtitle: '₦${state.availableCash.planDisplayAmount}',
            footerTitle:
                '${state.remainingPercent.toStringAsFixed(1)}% REMAINING',
            footerTitleColor: Color(0xff006E2F),
            extraWidget: SizedBox(
              width: double.infinity,
              height: 4,
              child: LinearProgressIndicator(
                value: state.remainingPercent,
                color: Color(0xff006E2F),
                borderRadius: BorderRadius.circular(999),
                // minHeight: 4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
