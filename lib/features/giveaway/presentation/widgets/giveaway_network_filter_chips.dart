import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class GiveawayNetworkFilterChips extends StatelessWidget {
  const GiveawayNetworkFilterChips({
    required this.labels,
    this.selectedIndex = 0,
    super.key,
    this.onIndexChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int>? onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(labels.length, (index) {
          final isSelected = index == selectedIndex;
          return Tappable.scaled(
            onTap: () => onIndexChanged?.call(index),
            child: Padding(
              padding: EdgeInsets.only(
                right: index == labels.length - 1 ? 0 : AppSpacing.md,
              ),
              child: Container(
                constraints: const BoxConstraints(minWidth: 80),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF0D1E3A)
                      : const Color(0xFFE9EEF8),
                  borderRadius: BorderRadius.circular(999),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[index].toUpperCase(),
                  style: poppinsTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? AppColors.white
                        : const Color(0xFF5B6473),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
