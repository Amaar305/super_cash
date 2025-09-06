import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/electricity_cubit.dart';

class ElectricityPlanDropdown extends StatelessWidget {
  const ElectricityPlanDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select((ElectricityCubit element) => element.state.status.isLoading);
    final plans =
        context.select((ElectricityCubit element) => element.state.plans.plans);
    return AppDropdownField.underlineBorder(
      enabled: !isLoading,
      items: plans.map((plan) => plan.discoName).toList(),
      onChanged: (plan) => context.read<ElectricityCubit>().onPlanSelection(
            plans.firstWhere(
              (element) => element.discoName == plan,
            ),
          ),
      hintText: 'Select',
    );
  }
}
