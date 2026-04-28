import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/giveaway/presentation/widgets/animated_text.dart';

class GiveawayCountdownBox extends StatelessWidget {
  const GiveawayCountdownBox({
    super.key,
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final String value;
  final String label;
  final bool highlight;

  static const _textDark = Colors.white70;
  final _primaryGreen = AppColors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedText(
              value: value,
              highlight: highlight,
              primaryGreen: _primaryGreen,
              textDark: _textDark,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                letterSpacing: .8,
                fontWeight: FontWeight.w800,
                color: AppColors.brightGrey,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
