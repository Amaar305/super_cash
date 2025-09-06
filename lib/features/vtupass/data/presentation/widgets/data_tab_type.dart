import 'package:super_cash/core/common/widgets/app_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/data_cubit.dart';

class DataTabType extends StatelessWidget {
  const DataTabType({super.key});

  @override
  Widget build(BuildContext context) {
    final isVtuSell = context.select((DataCubit c) => c.state.instantData);

    return AppTab(
      children: [
        AppTabItem(
          label: 'Instant Data',
          activeTab: isVtuSell,
          onTap: () => context.read<DataCubit>().onToggleShowPassword(true),
        ),
        AppTabItem(
          label: 'Scheduled Data',
          activeTab: !isVtuSell,
          onTap: () => context.read<DataCubit>().onToggleShowPassword(false),
        ),
      ],
    );
  }
}
