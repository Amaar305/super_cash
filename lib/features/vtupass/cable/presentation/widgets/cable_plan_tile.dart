import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CablePlanTile extends StatelessWidget {
  const CablePlanTile({
    super.key,
    required this.plan,
    this.onTap,
  });
  final Map plan;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      throttle: true,
      throttleDuration: 601.ms,
      onTap: onTap,
      child: Column(
        spacing: AppSpacing.xs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan['name'],
            style: TextStyle(fontWeight: AppFontWeight.medium),
          ),
          Text(
            "N${plan['variation_amount']}",
            style: TextStyle(
              fontWeight: AppFontWeight.medium,
              color: AppColors.blue,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
