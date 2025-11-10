import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class ReferralTypeOption extends StatelessWidget {
  const ReferralTypeOption({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    this.isSelected = false,
  });

  final String title;
  final String description;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(AppSpacing.md),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.blue : AppColors.brightGrey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        child: Row(
          spacing: AppSpacing.md,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.blue : AppColors.grey,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: poppinsTextStyle(
                      fontSize: AppSpacing.lg,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                  const Gap.v(AppSpacing.sm),
                  Text(
                    description,
                    style: poppinsTextStyle(color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
