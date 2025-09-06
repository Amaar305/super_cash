import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ReferalTotalNumberLabel extends StatelessWidget {
  const ReferalTotalNumberLabel({
    super.key,
    required this.totalNumber,
    required this.label,
  });
  final String totalNumber;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment(0, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSpacing.md),
            ),
            color: AppColors.buttonColor,
          ),
          child: Text(
            totalNumber,
            style: TextStyle(
              fontSize: AppSpacing.lg,
              color: AppColors.white,
            ),
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
