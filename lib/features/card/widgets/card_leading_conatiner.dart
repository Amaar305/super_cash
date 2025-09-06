import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CardLeadingConatiner extends StatelessWidget {
  const CardLeadingConatiner({
    super.key,
     this.leading,
  });

  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 51,
      height: 45,
      alignment: Alignment(0, 0),
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.xs + 1),
      ),
      child: leading,
    );
  }
}
