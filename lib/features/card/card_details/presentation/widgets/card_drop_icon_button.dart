import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardDropIconButton extends StatelessWidget {
  const CardDropIconButton({
    super.key,
    this.isExpanded = false,
    this.onTap,
  });
  final bool isExpanded;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.adaptiveColor.withValues(alpha: 0.1),
        ),
      ),
      child: Tappable.scaled(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Center(
          child: AnimatedCrossFade(
            firstChild: Assets.icons.chevronUp.svg(),
            secondChild: Assets.icons.chevronDown.svg(),
            crossFadeState: isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: 200.milliseconds,
          ),
        ),
      ),
    );
  }
}
