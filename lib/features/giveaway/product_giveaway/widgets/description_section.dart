part of '../pages/product_giveaway_details_page.dart';

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Description',
      icon: Icons.info_outline_rounded,
      iconColor: AppColors.blue,
      titleColor: const Color(0xFF1B2740),
      child: Text(
        details.description,
        style: poppinsTextStyle(
          color: const Color(0xFF5F6F89),
          fontSize: 11,
          fontWeight: AppFontWeight.medium,
        ),
      ),
    );
  }
}
