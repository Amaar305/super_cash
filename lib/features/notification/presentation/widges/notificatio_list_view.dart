import 'package:flutter/material.dart' hide Notification;
import 'package:shared/shared.dart';

import '../presentation.dart';

class NotificatioListView extends StatelessWidget {
  const NotificatioListView({super.key, required this.notifications});
  final List<Notification> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationTile(notification: notification);
      },
    );
  }
}
