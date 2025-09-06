import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/notification/notification.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

class FetchNotificationsUseCase
    implements UseCase<List<Notification>, NoParam> {
  final NotificationRepositories notificationRepositories;

  FetchNotificationsUseCase({required this.notificationRepositories});

  @override
  Future<Either<Failure, List<Notification>>> call(NoParam param) async {
    return notificationRepositories.fetchNotifications();
  }
}
