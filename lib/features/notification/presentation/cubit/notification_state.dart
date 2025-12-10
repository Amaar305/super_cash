// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

enum NotificationStatus {
  initial,
  loading,
  success,
  failure;

  bool get isError => this == NotificationStatus.failure;
  bool get isLoading => this == NotificationStatus.loading;
  bool get isSuccess => this == NotificationStatus.success;
}

class NotificationState extends Equatable {
  const NotificationState({
    required this.status,
    required this.notifications,
    required this.data,
    required this.message,
    required this.recent,
  });

  const NotificationState.initial()
      : this(
          data: const [],
          notifications: const [],
          message: '',
          status: NotificationStatus.initial,
          recent: true,
        );

  final NotificationStatus status;
  final List<Notification> notifications;
  final List<Notification> data;
  final String message;
  final bool recent;

  List<Notification> get recentNotifications {
    final cutoffDate = DateTime.now().subtract(const Duration(days: 7));

    return notifications
        .where((notification) => !notification.createdAt.isBefore(cutoffDate))
        .toList(growable: false);
  }

  @override
  List<Object> get props => [
        status,
        notifications,
        data,
        message,
        recent,
      ];

  NotificationState copyWith({
    NotificationStatus? status,
    List<Notification>? notifications,
    List<Notification>? data,
    String? message,
    bool? recent,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      data: data ?? this.data,
      message: message ?? this.message,
      recent: recent??this.recent,
    );
  }
}
