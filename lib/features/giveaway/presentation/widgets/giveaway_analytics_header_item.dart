import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class GiveawayAnalyticsHeaderItem extends StatelessWidget {
  const GiveawayAnalyticsHeaderItem({
    super.key,
    required this.icon,
    this.iconColor,
    required this.title,
    required this.subtitle,
    required this.footerTitle,
    this.footerTitleColor,
    this.extraWidget,
  });
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final String footerTitle;
  final Color? footerTitleColor;
  final Widget? extraWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: Color(0xFFE0E3E5).withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        spacing: AppSpacing.xs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 4,
            children: [
              Icon(icon, size: 16, color: iconColor),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  style: poppinsTextStyle(
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          Text(
            subtitle,
            style: poppinsTextStyle(
              fontWeight: AppFontWeight.black,
              fontSize: 16,
            ),
          ),
          ?extraWidget,
          Row(
            spacing: 2,
            children: [
              if (extraWidget == null)
                Icon(Icons.circle, color: AppColors.green, size: 6),
              Text(
                footerTitle,

                style: poppinsTextStyle(
                  fontSize: 10,
                  fontWeight: AppFontWeight.medium,
                  color: footerTitleColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
