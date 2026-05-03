part of '../pages/product_giveaway_details_page.dart';

class _StartAndEndDate extends StatelessWidget {
  const _StartAndEndDate({required this.giveaway});

  final Giveaway giveaway;

  @override
  Widget build(BuildContext context) {
    if (giveaway.startsAt == null || giveaway.endsAt == null) {
      return const SizedBox.shrink();
    }

    return Row(
      spacing: AppSpacing.lg,
      children: [
        Expanded(
          child: _InfoCard(
            title: 'STARTS ON',
            icon: Icons.calendar_month_outlined,
            iconColor: AppColors.blue,
            titleColor: const Color(0xFF64748B),
            child: FittedBox(
              child: Text(
                formatDateTime(giveaway.startsAt!),
                style: poppinsTextStyle(fontWeight: AppFontWeight.semiBold),
              ),
            ),
          ),
        ),
        Expanded(
          child: _InfoCard(
            title: 'ENDS ON',
            icon: Icons.calendar_month_outlined,
            iconColor: AppColors.red,
            titleColor: const Color(0xFF64748B),
            child: FittedBox(
              child: Text(
                formatDateTime(giveaway.endsAt!),
                style: poppinsTextStyle(fontWeight: AppFontWeight.semiBold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
