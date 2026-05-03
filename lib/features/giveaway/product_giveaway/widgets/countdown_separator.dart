part of '../pages/product_giveaway_details_page.dart';

class _CountdownSeparator extends StatelessWidget {
  const _CountdownSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ':',
        style: poppinsTextStyle(
          color: const Color(0xFF045A4E),
          fontSize: 30,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    );
  }
}
