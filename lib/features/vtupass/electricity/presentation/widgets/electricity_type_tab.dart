import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElectricityTypeTab extends StatelessWidget {
  const ElectricityTypeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isPrepaid = context.select(
      (ElectricityCubit cubit) => cubit.state.prepaid,
    );
    return VTPassTypeContainer(
      children: [
        VTPassTabItem(
          label: AppStrings.prepaid,
          onTap: () => context.read<ElectricityCubit>().onTypeChanged(true),
          activeTab: isPrepaid,
        ),
        VTPassTabItem(
          label: AppStrings.postpaid,
          onTap: () => context.read<ElectricityCubit>().onTypeChanged(false),
          activeTab: !isPrepaid,
        ),
      ],
    );
  }
}
