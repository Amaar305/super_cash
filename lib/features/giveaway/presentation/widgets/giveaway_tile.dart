import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayTile extends StatelessWidget {
  const GiveawayTile({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.status,
    this.isDisabled = false,
    this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final UpcomingGiveawayStatus status;
  final bool isDisabled;
  final VoidCallback? onTap;


  @override
  Widget build(BuildContext context) {
    final double opacity = isDisabled ? .55 : 1.0;

    return Tappable.faded(
      onTap: onTap,
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: 74,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Color(0xFFE6EFEA), width: 1.0),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xs,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: poppinsTextStyle(
                        fontSize: 14,
                        fontWeight: AppFontWeight.bold,
                        color: Color(0xFF0B1228),
                      ),
                    ),
      
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: poppinsTextStyle(
                        fontSize: 12,
                        fontWeight: AppFontWeight.semiBold,
                        color: Color(0xFF878A8F),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _StatusPill(status: status),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final UpcomingGiveawayStatus status;

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color fg;
    late final String text;

    switch (status) {
      case UpcomingGiveawayStatus.ongoing:
        text = "Ongoing";
        bg = const Color(0xFFE7FBF2);
        fg = AppColors.blue;
        break;
      case UpcomingGiveawayStatus.cancelled:
        text = "Cancelled";
        bg = const Color(0xFFFFF4D6);
        fg = const Color(0xFFB7791F);
        break;
      case UpcomingGiveawayStatus.completed:
        text = "Ended";
        bg = const Color(0xFFFFE3E3);
        fg = const Color(0xFFC53030);
        break;
      default:
        text = "Upcoming";
        bg = const Color(0xFFEFF6FF);
        fg = AppColors.blue;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: fg),
      ),
    );
  }
}
