import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/core/error/errorr_message.dart';
import 'package:super_cash/core/error/exception.dart';
import 'package:shared/shared.dart';
import 'package:token_repository/token_repository.dart';

abstract interface class NotificationRemoteDataSource {
  Future<List<Notification>> fetchNotifications();
  Future<bool> updateNotification({required String notificationId});
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final AuthClient apiClient;

  NotificationRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<Notification>> fetchNotifications() async {
    try {
      final response = await apiClient.request(
        method: 'GET',
        path: 'core/user-notifications/',
        body: jsonEncode({}),
      );

      Map<String, dynamic> res = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final message = extractErrorMessage(res);

        throw ServerException(message);
      }

      return List.from(
        res['results'],
      ).map((json) => Notification.fromJson(json)).toList();
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> updateNotification({required String notificationId}) async {
    try {
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
    } on RefreshTokenException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
