import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ManageBeneficiaryIconActionButton extends StatelessWidget {
  const ManageBeneficiaryIconActionButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tappable.scaled(
      onTap: onTap,
      child: Row(
        spacing: AppSpacing.xxs,
        children: [
          SizedBox.square(dimension: 20, child: icon),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
