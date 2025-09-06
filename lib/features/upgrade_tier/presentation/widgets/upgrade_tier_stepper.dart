import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpgradeTierStepper extends StatelessWidget {
  const UpgradeTierStepper({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = context.select(
      (UpgradeTierCubit cubit) => cubit.state.currentStep,
    );
    final totalStep = context.select(
      (UpgradeTierCubit cubit) => cubit.state.totalStep,
    );
    return VerificaionStepper(
      totalStep: totalStep,
      currentStep: currentStep,
      onStepClicked: (step) =>
          context.read<UpgradeTierCubit>().jumpToStep(step),
    );
  }
}
