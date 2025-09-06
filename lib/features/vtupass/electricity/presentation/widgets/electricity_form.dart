import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../vtupass.dart';

class ElectricityForm extends StatefulWidget {
  const ElectricityForm({super.key});

  @override
  State<ElectricityForm> createState() => _ElectricityFormState();
}

class _ElectricityFormState extends State<ElectricityForm> {
  @override
  void initState() {
    super.initState();
    context.read<ElectricityCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ElectricityCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ElectricityCubit, ElectricityState>(
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(
        spacing: AppSpacing.xlg,
        children: [
          ElectricityPlanDropdown(),
          ElectricityMeterNumberField(),
          ElectricityAmountField(),
          ElectricityPhoneField(),
        ],
      ),
    );
  }
}
