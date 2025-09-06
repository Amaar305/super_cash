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
  });

  const NotificationState.initial()
      : this(
          data: const [],
          notifications: const [],
          message: '',
          status: NotificationStatus.initial,
        );

  final NotificationStatus status;
  final List<Notification> notifications;
  final List<Notification> data;
  final String message;

  @override
  List<Object> get props => [
        status,
        notifications,
        data,
        message,
      ];

  NotificationState copyWith({
    NotificationStatus? status,
    List<Notification>? notifications,
    List<Notification>? data,
    String? message,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}
