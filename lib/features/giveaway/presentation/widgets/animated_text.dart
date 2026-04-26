import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
    required this.value,
    required this.highlight,
    required Color primaryGreen,
    required Color textDark,
  }) : _primaryGreen = primaryGreen,
       _textDark = textDark;

  final String value;
  final bool highlight;
  final Color _primaryGreen;
  final Color _textDark;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        final isIncoming = child.key == ValueKey(value);

        // Slide animation
        final slideAnimation = Tween<Offset>(
          begin: isIncoming ? const Offset(0, -1) : const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation);

        final fadeInanimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animation);

        return FadeTransition(
          opacity: fadeInanimation,
          child: SlideTransition(position: slideAnimation, child: child),
        );
      },
      child: Text(
        value,
        key: ValueKey(value),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: highlight ? _primaryGreen : _textDark,
          height: 1,
        ),
      ),
    );
  }
}
