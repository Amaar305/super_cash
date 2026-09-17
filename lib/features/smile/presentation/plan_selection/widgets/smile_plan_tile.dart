import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/smile/domain/domain.dart';

/// A single selectable Smile Data plan, styled as a clean rounded card.
class SmilePlanTile extends StatelessWidget {
  const SmilePlanTile({super.key, required this.plan, this.onTap});

  final SmilePlan plan;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.customReversedAdaptiveColor(
            dark: AppColors.emphasizeDarkGrey,
            light: AppColors.white,
          ),
          border: Border.all(color: AppColors.brightGrey),
        ),
        child: Row(
          spacing: AppSpacing.md,
          children: [
            CircleAvatar(
              radius: 18,

              backgroundImage: Assets.images.smile.image().image,
            ),
            Expanded(
              child: Text(
                plan.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: AppFontWeight.medium),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: AppSpacing.xs,
              children: [
                Text(
                  '₦${_formatted(plan.total)}',
                  style: const TextStyle(
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.blue,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.grey,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatted(double value) {
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(2);
  }
}
