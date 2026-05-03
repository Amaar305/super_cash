import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

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
          colors: [AppColors.black.withValues(alpha: 0.7), AppColors.black],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 14,
        children: [
          // FEATURED UPCOMING pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              newMethod(),
              Tappable.faded(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .35),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    spacing: AppSpacing.xs,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 12,
                        color: AppColors.white,
                      ),
                      Text(
                        'Details'.toUpperCase(),
                        style: TextStyle(fontSize: 10, color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

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
          Icon(Icons.circle, size: 10, color: AppColors.lightBlueFilled),
          SizedBox(width: 8),
          Text(
            "FEATURED UPCOMING",
            style: poppinsTextStyle(
              fontSize: 10,

              fontWeight: FontWeight.w800,
              color: AppColors.brightGrey,
            ).copyWith(letterSpacing: .5),
          ),
        ],
      ),
    );
  }
}
