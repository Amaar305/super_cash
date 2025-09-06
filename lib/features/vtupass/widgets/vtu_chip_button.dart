import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class VTUChipButton extends StatelessWidget {
  const VTUChipButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  });

  final String label;
  final Widget? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        // elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          // side: BorderSide(
          //   color: AppColors.primary2,
          // ),
        ),
        backgroundColor: AppColors.white,
      ),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.xs,
        children: [
          icon ?? SizedBox.shrink(),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: AppFontWeight.regular,
                color: AppColors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
