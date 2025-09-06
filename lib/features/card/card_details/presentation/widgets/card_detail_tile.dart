import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

import '../presentation.dart';

class CardDetailTile extends StatelessWidget {
  const CardDetailTile({
    super.key,
    required this.label,
    this.onExpanded,
    this.isExpanded = false,
  });

  final String label;
  final VoidCallback? onExpanded;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: onExpanded,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: poppinsTextStyle(
                  fontSize: AppSpacing.md + 1,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
              CardDropIconButton(onTap: onExpanded, isExpanded: isExpanded),
            ],
          ),
          Gap.v(AppSpacing.lg),
        ],
      ),
    );
  }
}
