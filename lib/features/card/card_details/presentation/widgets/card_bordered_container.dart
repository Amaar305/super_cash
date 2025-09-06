import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CardBorderedContainer extends StatelessWidget {
  const CardBorderedContainer({
    super.key,
    this.child,
    this.height = 300,
  });

  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.lg + 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.xs),
        border: Border.all(
          color: Color.fromRGBO(224, 232, 242, 1),
        ),
      ),
      child: child,
    );
  }
}
