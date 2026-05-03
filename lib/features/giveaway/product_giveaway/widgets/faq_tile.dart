part of '../pages/product_giveaway_details_page.dart';

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.item, required this.initiallyExpanded});

  final _FaqData item;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ProductGiveawayDetailsPage._cardBorder),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          iconColor: const Color(0xFF60756E),
          collapsedIconColor: const Color(0xFF60756E),
          title: Text(
            item.question,
            style: poppinsTextStyle(
              color: const Color(0xFF304641),
              fontSize: 12,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          children: [
            Text(
              item.answer,
              style: poppinsTextStyle(
                color: ProductGiveawayDetailsPage._softMuted,
                fontSize: 10,
                fontWeight: AppFontWeight.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqData {
  const _FaqData({required this.question, required this.answer});

  final String question;
  final String answer;
}
