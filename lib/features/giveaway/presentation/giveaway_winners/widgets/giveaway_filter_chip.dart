import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class GiveawayFilterChip extends StatelessWidget {
  const GiveawayFilterChip({
    super.key,
    required this.label,
    this.onChanged,
    required this.selected,
  });
  final String label;
  final bool selected;
  final void Function(String label)? onChanged;

  @override
  Widget build(BuildContext context) {
    var borderRadius2 = const BorderRadius.all(Radius.circular(14));

    final ctnColor = !selected
        ? AppColors.blue.withValues(alpha: 0.3)
        : AppColors.blue;

    return Tappable.scaled(
      onTap: () => onChanged?.call(label),
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: ctnColor, borderRadius: borderRadius2),
        child: Text(
          label,
          style: poppinsTextStyle(
            fontSize: 12,
            color: selected ? AppColors.white : null,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
      ),
    );
  }
}
