import 'dart:async';
import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class NewUpcomingGiveawayCard extends StatelessWidget {
  const NewUpcomingGiveawayCard({
    super.key,
    required this.giveaway,
    this.title,
    this.badgeText = 'FEATURED UPCOMING',
    this.hero,
    this.heroHeight = 288,
    this.onRulesTap,
    this.onDetailsTap,
    this.onNotifyTap,
  });

  final Giveaway giveaway;
  final String? title;
  final String badgeText;
  final Widget? hero;
  final double heroHeight;
  final VoidCallback? onRulesTap;
  final VoidCallback? onDetailsTap;
  final VoidCallback? onNotifyTap;

  static const _primary = Color(0xFF5248E5);

  @override
  Widget build(BuildContext context) {
    final startsAt = giveaway.startsAt ?? DateTime.now();
    final endsAt = giveaway.endsAt ?? DateTime.now();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: const Color(0xFFE7E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0E1320).withValues(alpha: 0.06),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: heroHeight - 64),
                _BlurredBody(
                  title: _displayTitle,
                  startsAt: startsAt,
                  endsAt: endsAt,
                  targetDate: startsAt,
                  onRulesTap: onRulesTap,
                  onDetailsTap: onDetailsTap,
                ),
              ],
            ),
            _HeroSection(
              height: heroHeight,
              badgeText: badgeText,
              onNotifyTap: onNotifyTap,
              child: hero ?? _DefaultHeroImage(image: giveaway.image),
            ),
          ],
        ),
      ),
    );
  }

  String get _displayTitle {
    if (title != null && title!.trim().isNotEmpty) {
      return title!.trim();
    }
    if (giveaway.valueToWin.trim().isNotEmpty) {
      return giveaway.valueToWin.trim();
    }
    return giveaway.giveawayType.name;
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.height,
    required this.badgeText,
    required this.child,
    this.onNotifyTap,
  });

  final double height;
  final String badgeText;
  final Widget child;
  final VoidCallback? onNotifyTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF242426), Color(0xFF3A3A3D)],
              ),
              borderRadius: BorderRadius.circular(34),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.14),
                    Colors.white.withValues(alpha: 0.92),
                  ],
                  stops: const [0, 0.62, 1],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
            child: Column(
              children: [
                Row(
                  children: [
                    _FeatureBadge(text: badgeText),
                    const Spacer(),
                    _NotifyButton(onTap: onNotifyTap),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurredBody extends StatelessWidget {
  const _BlurredBody({
    required this.title,
    required this.startsAt,
    required this.endsAt,
    required this.targetDate,
    this.onRulesTap,
    this.onDetailsTap,
  });

  final String title;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime targetDate;
  final VoidCallback? onRulesTap;
  final VoidCallback? onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(34)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.28),
                Colors.white.withValues(alpha: 0.88),
                Colors.white,
              ],
              stops: const [0, 0.12, 0.24],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 38, 24, 28),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF171B23),
                    height: 1.08,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Starts ${formatDateTime(startsAt)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF5B606C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ends ${formatDateTime(endsAt)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: NewUpcomingGiveawayCard._primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 26),
                _CountdownRow(targetDate: targetDate),
                const SizedBox(height: 26),
                Row(
                  children: [
                    Expanded(
                      child: _CardActionButton(
                        label: 'RULES',
                        isPrimary: false,
                        onTap: onRulesTap,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      flex: 2,
                      child: _CardActionButton(
                        label: 'DETAILS',
                        isPrimary: true,
                        onTap: onDetailsTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  const _FeatureBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: NewUpcomingGiveawayCard._primary,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: NewUpcomingGiveawayCard._primary.withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _NotifyButton extends StatelessWidget {
  const _NotifyButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF0F1F5),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const Padding(
          padding: EdgeInsets.all(14),
          child: Icon(
            Icons.notifications_none_rounded,
            color: NewUpcomingGiveawayCard._primary,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class _DefaultHeroImage extends StatelessWidget {
  const _DefaultHeroImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    if (image.trim().startsWith('http')) {
      return Image.network(
        image,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _assetFallback(),
      );
    }

    return _assetFallback();
  }

  Widget _assetFallback() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Assets.images.bg.image(fit: BoxFit.contain),
    );
  }
}

class _CountdownRow extends StatefulWidget {
  const _CountdownRow({required this.targetDate});

  final DateTime targetDate;

  @override
  State<_CountdownRow> createState() => _CountdownRowState();
}

class _CountdownRowState extends State<_CountdownRow> {
  Timer? _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = _timeLeft();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final next = _timeLeft();
      if (next != _remaining && mounted) {
        setState(() => _remaining = next);
      }
    });
  }

  Duration _timeLeft() {
    final diff = widget.targetDate.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Row(
      children: [
        Expanded(
          child: _CountdownTile(value: _two(days), label: 'DAYS'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _CountdownTile(value: _two(hours), label: 'HRS'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _CountdownTile(value: _two(minutes), label: 'MINS'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _CountdownTile(
            value: _two(seconds),
            label: 'SECS',
            highlight: true,
          ),
        ),
      ],
    );
  }

  String _two(int value) => value.toString().padLeft(2, '0');
}

class _CountdownTile extends StatelessWidget {
  const _CountdownTile({
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final String value;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E8F2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: highlight
                  ? NewUpcomingGiveawayCard._primary
                  : const Color(0xFF171B23),
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5E6470),
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardActionButton extends StatelessWidget {
  const _CardActionButton({
    required this.label,
    required this.isPrimary,
    this.onTap,
  });

  final String label;
  final bool isPrimary;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final background = isPrimary
        ? NewUpcomingGiveawayCard._primary
        : Colors.transparent;
    final foreground = isPrimary
        ? Colors.white
        : NewUpcomingGiveawayCard._primary;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isPrimary
                  ? Colors.transparent
                  : NewUpcomingGiveawayCard._primary.withValues(alpha: 0.24),
              width: 1.4,
            ),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: NewUpcomingGiveawayCard._primary.withValues(
                        alpha: 0.16,
                      ),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: foreground,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
