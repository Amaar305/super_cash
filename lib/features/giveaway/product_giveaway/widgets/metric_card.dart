part of '../pages/product_giveaway_details_page.dart';

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ProductGiveawayDetailsPage._cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: poppinsTextStyle(
              color: ProductGiveawayDetailsPage._softMuted,
              fontSize: 10,
              fontWeight: AppFontWeight.medium,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: poppinsTextStyle(
              color: const Color.fromARGB(255, 39, 43, 42),
              fontSize: 24,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.arrow_upward_rounded,
                size: 12,
                color: ProductGiveawayDetailsPage._softGreen,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  subtitle,
                  style: poppinsTextStyle(
                    color: ProductGiveawayDetailsPage._softGreen,
                    fontSize: 10,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
