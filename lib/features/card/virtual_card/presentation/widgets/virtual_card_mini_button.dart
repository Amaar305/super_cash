import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class VirtualCardMiniButton extends StatelessWidget {
  const VirtualCardMiniButton({
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
    return Material(
      elevation: 0.2,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(8),
      color: AppColors.white,
      child: Container(
        height: 44,
        width: 90,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.4,
            color: AppColors.lightBlueFilled,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Tappable(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.xs,
              children: [
                SizedBox.square(
                  dimension: 12,
                  child: icon ?? Assets.icons.addButton.svg(),
                ),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: AppSpacing.sm),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
