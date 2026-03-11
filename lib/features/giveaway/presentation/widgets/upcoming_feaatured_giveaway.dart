import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
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
    final formated = formatDateTime(giveaway.startsAt ?? DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          giveaway.giveawayType.name.capitalize,
          style: poppinsTextStyle(
            fontSize: 22,
            fontWeight: AppFontWeight.bold,
            color: textDark,
            // height: 1.1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          giveaway.description,
          style: poppinsTextStyle(
            fontSize: 14,
            color: subText,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),
        // countdown boxes
        _AnimatedCountdownBox(target: giveaway.startsAt ?? DateTime.now()),
        const SizedBox(height: 14),
        // start date row
        Row(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              size: 18,
              color: Color(0xFF5F6B6A),
            ),
            SizedBox(width: 8),
            Text(
              "Starts $formated",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF5F6B6A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
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
