import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class VTPassTypeContainer extends StatelessWidget {
  const VTPassTypeContainer({
    super.key,
    this.children,
  });

  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 200.ms,
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: Color.fromRGBO(239, 246, 255, 1),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        spacing: AppSpacing.xs,
        children: children ??
            [
              
            ],
      ),
    );
  }
}

class VTPassTabItem extends StatelessWidget {
  const VTPassTabItem({
    super.key,
    required this.label,
    this.activeTab = false,
    this.onTap,
  });
  final String label;
  final bool activeTab;
  final VoidCallback? onTap;
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
            color: activeTab ? AppColors.white : null,
            borderRadius: BorderRadius.circular(
              AppSpacing.xs,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: activeTab ? AppFontWeight.bold : null,
              color: activeTab ? null : AppColors.darkGrey,
            ),
          ),
        ),
      ),
    );
  }
}
