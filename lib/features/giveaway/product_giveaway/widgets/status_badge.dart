part of '../pages/product_giveaway_details_page.dart';

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: poppinsTextStyle(
          color: AppColors.white,
          fontSize: 9,
          fontWeight: AppFontWeight.semiBold,
        ),
      ),
    );
  }
}
