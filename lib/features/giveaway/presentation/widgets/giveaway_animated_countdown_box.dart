import 'dart:async';

import 'package:flutter/material.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class GiveawayAnimatedCountdownBox extends StatefulWidget {
  const GiveawayAnimatedCountdownBox({super.key, required this.target});
  final DateTime target;
  @override
  State<GiveawayAnimatedCountdownBox> createState() =>
      _GiveawayAnimatedCountdownBoxState();
}

class _GiveawayAnimatedCountdownBoxState
    extends State<GiveawayAnimatedCountdownBox> {
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
      spacing: 10,
      children: [
        Expanded(
          child: GiveawayCountdownBox(value: _two(_days), label: "DAYS"),
        ),

        Expanded(
          child: GiveawayCountdownBox(value: _two(_hrs), label: "HRS"),
        ),

        Expanded(
          child: GiveawayCountdownBox(value: _two(_mins), label: "MINS"),
        ),

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
