import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class VerificaionStepper extends StatelessWidget {
  const VerificaionStepper({
    super.key,
    this.currentStep = 1,
    required this.totalStep,
    this.onStepClicked,
  });

  final int currentStep;
  final int totalStep;
  final void Function(int)? onStepClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        Text(
          'Step $currentStep of $totalStep',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Row(
          spacing: AppSpacing.sm,
          children: List.generate(
            totalStep,
            (index) => Tappable.faded(
              throttle: true,
              throttleDuration: 200.ms,
              onTap: () {
                onStepClicked?.call(index + 1);
              },
              child: Container(
                width: 42,
                height: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: currentStep == index + 1
                      ? AppColors.buttonColor
                      : AppColors.brightGrey,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
