import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpgradeTierAppBarLeadingWidget extends StatelessWidget {
  const UpgradeTierAppBarLeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = context.select(
      (UpgradeTierCubit cubit) => cubit.state.currentStep,
    );
    final VoidCallback action = switch (currentStep) {
      1 => context.pop,
      2 => context.read<UpgradeTierCubit>().previousStep,
      _ => context.read<UpgradeTierCubit>().previousStep,
    };
    return AppLeadingAppBarWidget(onTap: action);
  }
}
