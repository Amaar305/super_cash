import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ValidationSummaryContainer extends StatelessWidget {
  const ValidationSummaryContainer({super.key, this.child});

 

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.brightGrey),
        color: context.customReversedAdaptiveColor(
          dark: AppColors.emphasizeDarkGrey,
          light: AppColors.white,
        ),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}


class ValidationDetailRow extends StatelessWidget {
  const ValidationDetailRow({
    super.key,
    required this.title,
    required this.value,
    this.color,
  });

  final String title;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bodySmall = context.bodySmall?.copyWith(
      color: AppColors.emphasizeGrey,
    );
    final bodyMedium = context.bodyMedium?.copyWith(
      fontWeight: AppFontWeight.semiBold,
      color: color,
    );

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.xs,
        children: [
          Text(title, style: bodySmall, textAlign: TextAlign.center),
          Text(value, style: bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
