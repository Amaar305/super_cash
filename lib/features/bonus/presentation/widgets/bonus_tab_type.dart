import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';

class BonusTabType extends StatelessWidget {
  const BonusTabType({super.key});

  @override
  Widget build(BuildContext context) {
    final tabValue = context.select(
      (BonusCubit element) => element.state.isBonusWithdrawn,
    );
    return AppTab(
      children: [
        AppTabItem(
          label: 'Bonus to Wallet',
          activeTab: tabValue,
          onTap: () => context.read<BonusCubit>().switchType(withdraw: true),
        ),
        AppTabItem(
          label: 'Bonus to Bank',
          activeTab: !tabValue,
          onTap: () => context.read<BonusCubit>().switchType(withdraw: false),
        ),
      ],
    );
  }
}
