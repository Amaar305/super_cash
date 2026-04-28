import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            Expanded(
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
                    _GiveawayEndsAt(
                      endsAt: giveaway.endsAt!,
                      subtextColor: subText,
                    ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppSpacing.sm,
                    children: [
                      Icon(
                        Icons.production_quantity_limits,
                        color: subText,
                        size: 15,
                      ),
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
                  _ViewMoreTextButton(),
                ],
              ),
            ),
          ],
        ),
        const Gap.v(AppSpacing.lg),
        Text(
          giveaway.description,
          style: poppinsTextStyle(
            fontSize: 12,
            color: subText,
            fontWeight: AppFontWeight.light,
          ),
        ),
        const Gap.v(AppSpacing.lg),

        // countdown boxes
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.lightDark,
            borderRadius: BorderRadius.all(Radius.circular(16)),
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
              _AnimatedCountdownBox(
                target: giveaway.startsAt ?? DateTime.now(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ViewMoreTextButton extends StatelessWidget {
  const _ViewMoreTextButton();

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: AppSpacing.xs,
        children: [
          Text(
            'View more',
            style:
                poppinsTextStyle(
                  color: AppColors.brightGrey,
                  fontWeight: AppFontWeight.bold,
                  fontSize: 12,
                ).copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                  decorationStyle: TextDecorationStyle.dotted,
                  decorationThickness: 2,
                ),
          ),
          Icon(
            Icons.visibility_outlined,
            color: AppColors.brightGrey,
            size: 15,
          ),
        ],
      ),
    );
  }
}

class _AnimatedCountdownBox extends StatefulWidget {
  const _AnimatedCountdownBox({required this.target});
  final DateTime target;
  @override
  State<_AnimatedCountdownBox> createState() => _AnimatedCountdownBoxState();
}

class _AnimatedCountdownBoxState extends State<_AnimatedCountdownBox> {
  Timer? _timer;

  int _days = 0;
  int _hrs = 0;
  int _mins = 0;
  int _secs = 0;

  @override
  void initState() {
    super.initState();
    _syncNow();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _syncNow());
  }

  void _syncNow() {
    final now = DateTime.now();
    var diff = widget.target.difference(now);

    if (diff.isNegative) diff = Duration.zero;

    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final mins = diff.inMinutes % 60;
    final secs = diff.inSeconds % 60;

    // Only rebuild when something changes
    if (days != _days || hours != _hrs || mins != _mins || secs != _secs) {
      setState(() {
        _days = days;
        _hrs = hours;
        _mins = mins;
        _secs = secs;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _two(int v) => v.toString().padLeft(2, '0');
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GiveawayCountdownBox(value: _two(_days), label: "DAYS"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GiveawayCountdownBox(value: _two(_hrs), label: "HRS"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GiveawayCountdownBox(value: _two(_mins), label: "MINS"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GiveawayCountdownBox(
            value: _two(_secs),
            label: "SECS",
            highlight: true,
          ),
        ),
      ],
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
