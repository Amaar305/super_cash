import 'package:flutter/material.dart';
import 'package:super_cash/features/kyc/kyc_status/cubit/kyc_status_cubit.dart';
import 'package:super_cash/features/kyc/kyc_status/widgets/kyc_step_tile.dart';

class KycStepsList extends StatelessWidget {
  const KycStepsList({super.key, required this.steps, required this.onStepTap});

  final List<KycStepItem> steps;
  final void Function(KycStepItem step) onStepTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < steps.length; i++)
          KycStepTile(
            item: steps[i],
            isLast: i == steps.length - 1,
            onTap: () => onStepTap(steps[i]),
          ),
      ],
    );
  }
}
