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

  static const _textDark = Color(0xFF0B1228);
  final _primaryGreen = AppColors.deepBlue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEBFBF1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedText(
            // key: ValueKey(value),
            value: value,
            highlight: highlight,
            primaryGreen: _primaryGreen,
            textDark: _textDark,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              letterSpacing: .8,
              fontWeight: FontWeight.w800,
              color: Color(0xFF7C8A88),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
