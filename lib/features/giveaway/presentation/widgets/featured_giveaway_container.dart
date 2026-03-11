import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class FeaturedGiveawayContainer extends StatelessWidget {
  const FeaturedGiveawayContainer({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.lightBlue.withValues(alpha: 0.8),
            AppColors.lightBlue.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          // FEATURED UPCOMING pill
          newMethod(),

          child ?? SizedBox.shrink(),
        ],
      ),
    );
  }

  Container newMethod() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .35),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 10, color: AppColors.deepBlue),
          SizedBox(width: 8),
          Text(
            "FEATURED UPCOMING",
            style: TextStyle(
              fontSize: 10,
              letterSpacing: .5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A2B2A),
            ),
          ),
        ],
      ),
    );
  }
}
