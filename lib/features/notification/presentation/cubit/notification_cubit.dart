import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/notification/notification.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared/shared.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final FetchNotificationsUseCase _fetchNotificationsUseCase;
  final UpdateNotificationUseCase _updateNotificationUseCase;

  NotificationCubit({
    required FetchNotificationsUseCase fetchNotificationsUseCase,
    required UpdateNotificationUseCase updateNotificationUseCase,
  }) : _fetchNotificationsUseCase = fetchNotificationsUseCase,
       _updateNotificationUseCase = updateNotificationUseCase,
       super(NotificationState.initial());

  void showRecent(bool showRecent) {
    if (showRecent == state.recent) return;

    emit(state.copyWith(recent: showRecent));
  }

  Future<void> fetchInitialNotification() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        status: NotificationStatus.loading,
        data: [],
        notifications: [],
      ),
    );

    try {
      final res = await _fetchNotificationsUseCase(NoParam());

      res.fold(
        (failure) {
          emit(
            state.copyWith(
              status: NotificationStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          emit(
            state.copyWith(
              status: NotificationStatus.success,
              data: success,
              notifications: success,
              message: "Successfully load initial notifications",
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.failure,
          message: "Fail to load initial notifications.",
        ),
      );
    }
  }

  Future<void> updateNotification({required String notificationId}) async {
    if (isClosed) return;

    emit(state.copyWith(status: NotificationStatus.failure));

    try {
      final res = await _updateNotificationUseCase(
        UpdateNotificationParams(notificationId: notificationId),
      );

      res.fold(
        (failure) {
          emit(
            state.copyWith(
              status: NotificationStatus.failure,
              message: failure.message,
            ),
          );
        },
        (success) {
          if (success) {
            // Create a new list from the current state notifications
            final notifications = List<Notification>.from(state.notifications);

            // Find the index of the notification to update
            final index = notifications.indexWhere(
              (element) => element.id == notificationId,
            );

            if (index != -1) {
              // Update the notification with read = true
              final updatedNotification = notifications[index].copyWith(
                read: true,
              );

              // Replace the old notification with the updated one
              notifications[index] = updatedNotification;

              // Emit new state with updated notifications list
              emit(
                state.copyWith(
                  status: NotificationStatus.success,
                  message: "Successfully updated read notification.",
                  notifications: notifications,
                ),
              );
            } else {
              // Handle case where notificationId was not found (optional)
              emit(
                state.copyWith(
                  status: NotificationStatus.failure,
                  message: "Notification not found.",
                ),
              );
            }
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.failure,
          message: "Fail to update read notifications.",
        ),
      );
    }
  }

  Future<void> refreshNotifications() async {
    if (isClosed) return;
    emit(NotificationState.initial());
    fetchInitialNotification();
  }
}
