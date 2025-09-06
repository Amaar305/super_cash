import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../../home.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome,',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          Spacer(),
          HomeNotificationBadge(),
          Gap.h(AppSpacing.md),
          SizedBox.square(
            dimension: 24,
            child: Assets.icons.menu.svg(),
          ),
        ],
      ),
    );
  }
}
