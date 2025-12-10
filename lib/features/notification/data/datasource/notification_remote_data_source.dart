import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';

abstract interface class NotificationRemoteDataSource {
  Future<List<Notification>> fetchNotifications();
  Future<bool> updateNotification({required String notificationId});
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final AuthClient apiClient;

  const NotificationRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<Notification>> fetchNotifications() async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'core/user-notifications/',
    );

    final res = jsonDecode(response.body);
    logD(res);
    return List.from(res, growable: false).map((json) {
      return Notification.fromJson(Map<String, dynamic>.from(json));
    }).toList();
  }

  @override
  Future<bool> updateNotification({required String notificationId}) async {
    final response = await apiClient.request(
      method: 'POST',
      path: 'core/user/update-notification/',
      body: jsonEncode({'notification_id': notificationId}),
    );

    Map<String, dynamic> res = jsonDecode(response.body);

    if (response.statusCode != 201) {
      final message = extractErrorMessage(res);

      throw ServerException(message);
    }

    return res['notification_status'];
  }
}
