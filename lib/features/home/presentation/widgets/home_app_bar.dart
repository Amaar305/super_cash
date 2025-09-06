import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/home/home.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      elevation: 1,
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          width: double.infinity,
          height: 78,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
              right: 16,
              bottom: 8,
              left: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    HomeWelcomeText(),
                    Spacer(),
                    HomeNotificationBadge(),
                    Gap.h(AppSpacing.md),
                    SizedBox.square(
                      dimension: 24,
                      child: Assets.icons.menu.svg(
                        colorFilter: ColorFilter.mode(
                          AppColors.background,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
                // Gap.v(AppSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
