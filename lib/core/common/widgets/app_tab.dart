import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class AppTab extends StatelessWidget {
  const AppTab({super.key, this.children, this.backgroundColor});
  final List<AppTabItem>? children;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 200.ms,
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary2,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(spacing: AppSpacing.xs, children: children ?? []),
    );
  }
}

class AppTabItem extends StatelessWidget {
  const AppTabItem({
    super.key,
    required this.label,
    this.activeTab = false,
    this.onTap,
    this.activeColor,
    this.activeTextColor,
  });
  final String label;
  final bool activeTab;
  final VoidCallback? onTap;
  final Color? activeColor;
  final Color? activeTextColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Tappable(
        onTap: onTap,
        child: Container(
          alignment: Alignment(0, 0),
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: activeTab ? activeColor ?? AppColors.white : null,
            borderRadius: BorderRadius.circular(AppSpacing.xs),
          ),
          child: Text(
            label,
            style: MonaSansTextStyle.label(
              fontWeight: AppFontWeight.bold,
              color: activeTab ? activeTextColor : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
