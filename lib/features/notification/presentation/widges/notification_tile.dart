import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notification});

  final Notification notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.lightBlue.withValues(alpha: 0.3),
        child: Icon(Icons.notifications, color: AppColors.blue),
      ),
      title: Text(
        notification.title,
        style: poppinsTextStyle(fontWeight: AppFontWeight.semiBold),
      ),
      subtitle: Text(
        notification.description,
        style: poppinsTextStyle(fontSize: 12),
      ),
    );
  }
}
