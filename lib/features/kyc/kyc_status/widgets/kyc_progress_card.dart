import 'dart:math' as math;

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class KycProgressCard extends StatelessWidget {
  const KycProgressCard({
    super.key,
    required this.progressLabel,
    required this.progressValue,
  });

  final String progressLabel;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.isLight
            ? const Color(0xFFF3F4F6)
            : const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  progressLabel,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: AppFontWeight.bold,
                    color: context.adaptiveColor,
                  ),
                ),
                const Gap.v(AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 6,
                    backgroundColor: context.isLight
                        ? const Color(0xFFDDE0E6)
                        : const Color(0xFF333333),
                    valueColor: const AlwaysStoppedAnimation(AppColors.blue),
                  ),
                ),
              ],
            ),
          ),
          const Gap.h(AppSpacing.xlg),
          _CircularPercent(value: progressValue),
        ],
      ),
    );
  }
}

class _CircularPercent extends StatelessWidget {
  const _CircularPercent({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).round();
    return SizedBox(
      width: 56,
      height: 56,
      child: CustomPaint(
        painter: _RingPainter(
          value: value,
          trackColor: context.isLight
              ? const Color(0xFFDDE0E6)
              : const Color(0xFF333333),
          progressColor: AppColors.blue,
          strokeWidth: 5,
        ),
        child: Center(
          child: Text(
            '$percent%',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFontWeight.semiBold,
              color: context.adaptiveColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.value,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  final double value;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    paint.color = trackColor;
    canvas.drawCircle(center, radius, paint);

    paint.color = progressColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * value,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value || old.progressColor != progressColor;
}
