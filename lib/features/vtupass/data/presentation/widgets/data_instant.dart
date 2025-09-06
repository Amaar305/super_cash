import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';

class DataInstant extends StatelessWidget {
  const DataInstant({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        DataPhoneField(),
        DataVTUButtons(),
        DataNetworkProvider(),
        DataPlanTypeWidget(),
        DataPlanDurationWidget(),
        DataPlansSection(),
        Gap.v(AppSpacing.xxxs),
        DataButton(),
      ],
    );
  }
}
