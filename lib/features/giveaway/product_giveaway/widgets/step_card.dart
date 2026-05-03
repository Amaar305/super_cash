part of '../pages/product_giveaway_details_page.dart';

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step});

  final _StepData step;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ProductGiveawayDetailsPage._cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ProductGiveawayDetailsPage._primaryCta,
            ),
            child: Center(
              child: Text(
                '${step.number}',
                style: poppinsTextStyle(
                  color: AppColors.white,
                  fontSize: 11,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: poppinsTextStyle(
                    color: const Color(0xFF304641),
                    fontSize: 13,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.description,
                  style: poppinsTextStyle(
                    color: ProductGiveawayDetailsPage._softMuted,
                    fontSize: 10,
                    fontWeight: AppFontWeight.medium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepData {
  const _StepData({
    required this.number,
    required this.title,
    required this.description,
  });

  final int number;
  final String title;
  final String description;
}
