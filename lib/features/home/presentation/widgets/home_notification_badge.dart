import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeNotificationBadge extends StatelessWidget {
  const HomeNotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable.scaled(
      onTap: () => context.push(AppRoutes.notifications),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.primary2,
            child: Icon(
              Icons.notifications_outlined,
              size: AppSize.iconSizeMedium,
              color: AppColors.white,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              radius: 6,
              backgroundColor: AppColors.red,
              child: Text(
                '3',
                style: TextStyle(fontSize: 8, color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
