import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class CashGiveawayHeader extends StatelessWidget {
  const CashGiveawayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((CashGiveawayCubit c) => c.state);

    return Row(
      spacing: AppSpacing.lg,
      children: [
        Expanded(
          child: HeaderItem(
            title: 'TOTAL PRIZE POOL',
            icon: Icons.monetization_on,
            subtitle: '₦${state.totalCash}',
            footerTitle: 'Across all active drops',
          ),
        ),
        Expanded(
          child: HeaderItem(
            title: 'AVAILABLE TO CLAIM',
            icon: Icons.wallet_outlined,
            iconColor: Color(0xff006E2F),
            subtitle: '₦${state.availableCash}',
            footerTitle: '${state.remainingPercent}% REMAINING',
            footerTitleColor: Color(0xff006E2F),
            extraWidget: SizedBox(
              width: double.infinity,
              height: 4,
              child: LinearProgressIndicator(
                value: state.remainingPercent,
                color: Color(0xff006E2F),
                borderRadius: BorderRadius.circular(999),
                // minHeight: 4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderItem extends StatelessWidget {
  const HeaderItem({
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
