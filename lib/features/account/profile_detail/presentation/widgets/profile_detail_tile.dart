import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfileDetailTile extends StatelessWidget {
  const ProfileDetailTile({
    super.key,
    required this.label,
    required this.trailingLabel,
    this.trailingLabelColor,
  });

  final String label;
  final String trailingLabel;
  final Color? trailingLabelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        spacing: AppSpacing.sm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: poppinsTextStyle(
                  fontWeight: AppFontWeight.regular,
                  color: trailingLabelColor,
                  fontSize: AppSpacing.md,
                ),
              ),
              Flexible(
                child: Text(
                  trailingLabel,
                  style: poppinsTextStyle(
                    fontWeight: AppFontWeight.regular,
                    color: trailingLabelColor,
                    fontSize: AppSpacing.md,
                  ),
                ),
              ),
            ],
          ),
          Divider(thickness: 0.7, color: Color.fromRGBO(237, 238, 242, 0.9)),
        ],
      ),
    );
  }
}
