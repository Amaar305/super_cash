import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class HistoryDetailTile extends StatelessWidget {
  const HistoryDetailTile({
    super.key,
    required this.label,
    required this.trailingLabel,
  });

  final String label;
  final String trailingLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        spacing: AppSpacing.xs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: poppinsTextStyle(
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: 12,
                ),
              ),
              Flexible(
                child: Text(
                  trailingLabel,
                  textAlign: TextAlign.end,
                  style: poppinsTextStyle(
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            // thickness: 0.7,
            color: Color.fromRGBO(237, 238, 242, 0.9),
          ),
        ],
      ),
    );
  }
}
