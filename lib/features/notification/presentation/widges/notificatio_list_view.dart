import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:shared/shared.dart';

import '../presentation.dart';

class NotificatioListView extends StatelessWidget {
  const NotificatioListView({super.key, required this.notifications});
  final List<Notification> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notifications.length,
      separatorBuilder: (context, index) => Container(
        width: context.screenWidth * 0.8,
        height: 0.2,
        color: AppColors.grey,
      ),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationTile(notification: notification);
      },
    );
  }
}
