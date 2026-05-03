part of '../pages/product_giveaway_details_page.dart';

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.titleColor,
    required this.child,
    // ignore: unused_element_parameter
    this.accentColor,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Color titleColor;
  final Widget child;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E8F0)),
      ),
      child: Stack(
        children: [
          if (accentColor != null)
            Positioned(
              left: -18,
              top: -18,
              bottom: -16,
              child: Container(width: 6, color: accentColor),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: iconColor, size: 22),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: poppinsTextStyle(
                      color: titleColor,
                      fontSize: 14,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ],
      ),
    );
  }
}
