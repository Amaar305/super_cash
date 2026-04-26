import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    this.endsAt,
    this.onTap,
    this.image,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final UpcomingGiveawayStatus status;
  final DateTime? endsAt;
  final bool isDisabled;
  final VoidCallback? onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final double opacity = isDisabled ? .55 : 1.0;

    return Tappable.faded(
      onTap: isDisabled ? null : onTap,
      child: Opacity(
        opacity: opacity,
        child: _GiveawayTileCard(
          status: status,
          title: title,
          subtitle: subtitle,
          endsAt: endsAt,
          image: image,
          icon: icon,
          iconColor: iconColor,
          iconBg: iconBg,
        ),
      ),
    );
  }
}

class _GiveawayTileCard extends StatelessWidget {
  const _GiveawayTileCard({
    required this.status,
    required this.title,
    required this.subtitle,
    required this.endsAt,
    this.image,
    this.iconBg,
    this.icon,
    this.iconColor,
  });

  final UpcomingGiveawayStatus status;
  final String title;
  final String subtitle;
  final DateTime? endsAt;
  final String? image;
  final Color? iconBg;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFC5C6D0), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.md,
        children: [
          GiveawayImage(
            status: status,
            image: image,
            icon: icon,
            iconBg: iconBg,
            iconColor: iconColor,
          ),
          Expanded(
            child: _GiveawayDetails(
              title: title,
              subtitle: subtitle,
              endsAt: endsAt,
            ),
          ),
        ],
      ),
    );
  }
}

class _GiveawayDetails extends StatelessWidget {
  const _GiveawayDetails({
    required this.title,
    required this.subtitle,
    required this.endsAt,
  });

  final String title;
  final String subtitle;
  final DateTime? endsAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        _GiveawayTitle(title: title),
        _GiveawaySubtitle(subtitle: subtitle),
        if (endsAt != null) _GiveawayEndsAt(endsAt: endsAt!),
        const Gap.v(AppSpacing.xs),
        const _GiveawayActionButton(),
      ],
    );
  }
}

class _GiveawayTitle extends StatelessWidget {
  const _GiveawayTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: poppinsTextStyle(
        fontSize: 14,
        fontWeight: AppFontWeight.bold,
        color: const Color(0xFF0B1228),
      ),
    );
  }
}

class _GiveawaySubtitle extends StatelessWidget {
  const _GiveawaySubtitle({required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: poppinsTextStyle(
          fontSize: 12,
          fontWeight: AppFontWeight.light,
          color: AppColors.darkGrey,
        ),
      ),
    );
  }
}

class _GiveawayEndsAt extends StatelessWidget {
  const _GiveawayEndsAt({required this.endsAt});

  final DateTime endsAt;

  @override
  Widget build(BuildContext context) {
    final String formattedEndsAt = DateFormat(
      'MMM d, h:mm a',
    ).format(endsAt).toUpperCase();
    final color = AppColors.red;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.sm,
      children: [
        Icon(Icons.history_toggle_off_sharp, color: color, size: 15),
        Expanded(
          child: Text(
            "ENDS IN: $formattedEndsAt",
            style: poppinsTextStyle(
              fontSize: 10,
              fontWeight: AppFontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _GiveawayActionButton extends StatelessWidget {
  const _GiveawayActionButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: '',
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(160, 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(AppSpacing.md),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        backgroundColor: AppColors.black.withValues(alpha: 0.7),
      ),
      child: const Text(
        'ENTER NOW',
        style: TextStyle(color: Color(0xFFF1F1F1)),
      ),
    );
  }
}

class GiveawayImage extends StatelessWidget {
  const GiveawayImage({
    super.key,
    required this.status,
    this.image,
    this.iconBg,
    this.icon,
    this.iconColor,
  });
  final UpcomingGiveawayStatus status;
  final String? image;
  final Color? iconBg;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        _buildImage(),
        Positioned(left: 8, top: 6, child: _StatusPill(status: status)),
      ],
    );
  }

  Container _buildImage() {
    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.brightGrey,
      ),
      child: image == null || image!.isEmpty
          ? Icon(icon, color: iconColor, size: 22)
          : ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(image!, fit: BoxFit.cover),
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
      width: 51.22,
      height: 15,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: FittedBox(
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w900,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }
}
