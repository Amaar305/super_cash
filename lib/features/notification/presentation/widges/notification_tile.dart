import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:shared/shared.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
  });

  final Notification notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
      ),
      // onTap: () {},
      // selected: true,
      // selectedTileColor: AppColors.lightBlue.withValues(alpha: 0.1),
      title: Text(
        notification.title,
        style: context.bodySmall?.copyWith(fontWeight: AppFontWeight.semiBold),
      ),
      subtitle: Text(
        notification.description,
        style: TextStyle(fontSize: 10),
      ),
    );
  }
}
