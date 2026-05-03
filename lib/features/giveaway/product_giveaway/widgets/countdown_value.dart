part of '../pages/product_giveaway_details_page.dart';

class _CountdownValue extends StatelessWidget {
  const _CountdownValue({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: poppinsTextStyle(
                color: AppColors.black,
                fontSize: 30,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: poppinsTextStyle(
              color: const Color(0xFF94A3B8),
              fontSize: 10,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
