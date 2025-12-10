import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class ReferalTotalNumberLabel extends StatelessWidget {
  const ReferalTotalNumberLabel({
    super.key,
    required this.totalNumber,
    required this.label,
    this.active = false,
    this.onTap,
  });
  final String totalNumber;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: onTap,
      child: Column(
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
              style: TextStyle(fontSize: AppSpacing.lg, color: AppColors.white),
            ),
          ),
          if (active)
            AnimatedContainer(
              duration: 200.ms,
              height: 3,
              width: 20,
              color: AppColors.blue,
            ),
          Text(label, style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}
