part of '../pages/product_giveaway_details_page.dart';

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ProductGiveawayDetailsPage._heroTop,
            ProductGiveawayDetailsPage._heroBottom,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(child: _HeroImage(imageUrl: details.imageUrl)),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.10),
                      Colors.black.withValues(alpha: 0.15),
                      Colors.black.withValues(alpha: 0.42),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatusBadge(text: details.statusBadgeText),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 190),
                    child: Text(
                      details.heroTitle,
                      style: poppinsTextStyle(
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: Color(0xFFDDE9E5),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        details.countdownLabel,
                        style: poppinsTextStyle(
                          color: const Color(0xFFDDE9E5),
                          fontSize: 11,
                          fontWeight: AppFontWeight.medium,
                        ),
                      ),
                    ],
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
