import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_strings/app_string.dart';

class VirtualCardCreateButton extends StatelessWidget {
  const VirtualCardCreateButton({
    super.key,
    required this.label,
    this.onTap,
  });
  final String label;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: label,
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.sm,
        children: [
          SizedBox.square(
            dimension: 24,
            child: Assets.icons.createCard.svg(),
          ),
          Text(
            AppStrings.createNewVirtualCard,
            style: TextStyle(
              fontWeight: AppFontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
