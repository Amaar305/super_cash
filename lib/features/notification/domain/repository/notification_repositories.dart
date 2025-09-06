import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract interface class NotificationRepositories {
  Future<Either<Failure, List<Notification>>> fetchNotifications();
  Future<Either<Failure, bool>> updateNotifications({
    required String notificationId,
  });
}
