import 'package:super_cash/core/common/widgets/app_tab.dart';
import 'package:super_cash/features/vtupass/airtime/airtime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AirtimeTabType extends StatelessWidget {
  const AirtimeTabType({super.key});

  @override
  Widget build(BuildContext context) {
    final isVtuSell = context.select((AirtimeCubit c) => c.state.vtuSell);

    return AppTab(
      children: [
        AppTabItem(
          label: 'VTU Sell',
          activeTab: isVtuSell,
          onTap: () => context.read<AirtimeCubit>().onToggleShowPassword(true),
        ),
        AppTabItem(
          label: 'Share and Sell',
          activeTab: !isVtuSell,
          onTap: () => context.read<AirtimeCubit>().onToggleShowPassword(false),
        ),
      ],
    );
  }
}
