import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:super_cash/features/card/widgets/card_collapsable_tile.dart';
import 'package:flutter/material.dart';

class CardQuickActionTile extends StatelessWidget {
  const CardQuickActionTile({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
  });
  final String title;
  final VoidCallback? onTap;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: AppSpacing.lg),
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.md + 2,
          horizontal: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.sm - 1),
          border: Border.all(color: AppColors.blue.withValues(alpha: 0.097)),
        ),
        alignment: Alignment(0, 0),
        child: CardCollapsableTile(
          leading: leading,
          title: title,
          onTap: onTap,
        ),
      ),
    );
  }
}
