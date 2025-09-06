import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../notification.dart';

class NotificationRepositoriesImpl implements NotificationRepositories {
  final NotificationRemoteDataSource notificationRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  NotificationRepositoriesImpl({
    required this.notificationRemoteDataSource,
    required this.apiErrorHandler,
  });

  @override
  Future<Either<Failure, List<Notification>>> fetchNotifications() async {
    try {
      final response = await notificationRemoteDataSource.fetchNotifications();
      return right(response);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, bool>> updateNotifications({
    required String notificationId,
  }) async {
    try {
      final response = await notificationRemoteDataSource.updateNotification(
        notificationId: notificationId,
      );
      return right(response);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
}
