import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class UpcomingFeaaturedGiveaway extends StatelessWidget {
  const UpcomingFeaaturedGiveaway({
    super.key,
    required this.textDark,
    required this.subText,
    required this.giveaway,
  });

  final Color textDark;
  final Color subText;
  final Giveaway giveaway;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: AppSpacing.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _DefaultHeroImage(image: giveaway.image)),
            _GiveawayInfo(
              giveaway: giveaway,
              textDark: textDark,
              subText: subText,
            ),
          ],
        ),
        const Gap.v(AppSpacing.lg),
        Text(
          giveaway.description,
          style: poppinsTextStyle(
            fontSize: 12,
            color: subText,
            // fontWeight: AppFontWeight.light,
          ).copyWith(height: 1.6),
        ),
        const Gap.v(AppSpacing.lg),

        // countdown boxes
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(AppSpacing.md),
          ),
          child: Column(
            children: [
              Text(
                "Giveaway starts in:",
                style: poppinsTextStyle(
                  fontSize: 12,
                  color: subText,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
              const Gap.v(AppSpacing.sm),
              GiveawayAnimatedCountdownBox(
                target: giveaway.startsAt ?? DateTime.now(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GiveawayInfo extends StatelessWidget {
  const _GiveawayInfo({
    required this.giveaway,
    required this.textDark,
    required this.subText,
  });

  final Giveaway giveaway;
  final Color textDark;
  final Color subText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        spacing: AppSpacing.sm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            giveaway.giveawayType.name.capitalize,
            style: poppinsTextStyle(
              fontSize: 22,
              fontWeight: AppFontWeight.bold,
              color: textDark,
            ),
          ),
          if (giveaway.startsAt != null)
            _GiveawayEndsAt(
              endsAt: giveaway.startsAt!,
              prefix: 'STARTS IN:',
              subtextColor: subText,
            ),
          if (giveaway.endsAt != null)
            _GiveawayEndsAt(endsAt: giveaway.endsAt!, subtextColor: subText),

          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.sm,
            children: [
              Icon(Icons.production_quantity_limits, color: subText, size: 15),
              Text(
                "VALUE TO WIN: ${giveaway.valueToWin}",
                style: poppinsTextStyle(
                  fontSize: 10,
                  fontWeight: AppFontWeight.bold,
                  color: subText,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          Tappable.faded(
            onTap: () {
              context.pushNamed(
                RNames.givewayDetail,
                pathParameters: {
                  'giveaway_type_id': giveaway.giveawayType.id.toString(),
                },
                extra: GivewayDetailRouteData.fromGiveaway(giveaway),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.only(top: 4, right: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                spacing: AppSpacing.sm,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 14, color: AppColors.black),
                  Text(
                    'Details'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.black,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultHeroImage extends StatelessWidget {
  const _DefaultHeroImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    Widget child = _assetFallback();
    if (image.trim().startsWith('http')) {
      child = Image.network(
        image,
        fit: BoxFit.cover,

        errorBuilder: (_, __, ___) => _assetFallback(),
      );
    }
    return Container(
      width: 128,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        child: child,
      ),
    );
  }

  Widget _assetFallback() {
    return Assets.images.bg.image(fit: BoxFit.cover);
  }
}

class _GiveawayEndsAt extends StatelessWidget {
  const _GiveawayEndsAt({
    required this.endsAt,
    this.prefix = 'ENDS IN:',
    this.subtextColor = const Color(0xFF4E45E4),
  });

  final DateTime endsAt;
  final String prefix;
  final Color? subtextColor;

  @override
  Widget build(BuildContext context) {
    final String formattedEndsAt = DateFormat(
      'MMM d, h:mm a',
    ).format(endsAt).toUpperCase();

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.sm,
      children: [
        Icon(Icons.history_toggle_off_sharp, color: subtextColor, size: 15),
        Expanded(
          child: Text(
            "$prefix $formattedEndsAt",
            style: poppinsTextStyle(
              fontSize: 10,
              fontWeight: AppFontWeight.bold,
              color: subtextColor,
            ),
          ),
        ),
      ],
    );
  }
}
