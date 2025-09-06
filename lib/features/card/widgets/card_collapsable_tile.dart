import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:flutter/material.dart';

class CardCollapsableTile extends StatelessWidget {
  const CardCollapsableTile({
    super.key,
    this.leading,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  final Widget? leading;
  final Widget? trailing;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardLeadingConatiner(leading: leading),
        Gap.h(AppSpacing.xlg),
        Text(
          title,
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        Spacer(),
        if (trailing != null)
          trailing!
        else
          Tappable.scaled(
            onTap: onTap,
            child: Icon(Icons.arrow_forward_ios, size: AppSize.iconSizeXSmall),
          ),
      ],
    );
  }
}
