import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/notification/domain/repository/notification_repositories.dart';
import 'package:fpdart/fpdart.dart';

class UpdateNotificationUseCase
    implements UseCase<bool, UpdateNotificationParams> {
  final NotificationRepositories notificationRepositories;

  UpdateNotificationUseCase({required this.notificationRepositories});

  @override
  Future<Either<Failure, bool>> call(UpdateNotificationParams param) async {
    return notificationRepositories.updateNotifications(
      notificationId: param.notificationId,
    );
  }
}

class UpdateNotificationParams {
  final String notificationId;

  UpdateNotificationParams({required this.notificationId});
}
