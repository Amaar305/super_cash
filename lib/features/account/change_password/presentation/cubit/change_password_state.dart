part of 'change_password_cubit.dart';

enum ChangePasswordStatus {
  initial,
  loading,
  success,
  failure;

  bool get isError => this == ChangePasswordStatus.failure;
  bool get isLoading => this == ChangePasswordStatus.loading;
  bool get isSuccess => this == ChangePasswordStatus.success;
}

class ChangePasswordState extends Equatable {
  const ChangePasswordState._({
    required this.status,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.message,
    this.doesNotMatchedMessage,
    this.showCurrentPassword = false,
    this.shownewPassword = false,
    this.showConfirmPassword = false,
  });

  const ChangePasswordState.initial()
      : this._(
          status: ChangePasswordStatus.initial,
          currentPassword: const Password.pure(),
          newPassword: const Password.pure(),
          confirmPassword: const Password.pure(),
          message: '',
        );

  final ChangePasswordStatus status;
  final String message;
  final Password currentPassword;
  final Password newPassword;
  final Password confirmPassword;
  final bool showCurrentPassword;
  final bool shownewPassword;
  final bool showConfirmPassword;
  final String? doesNotMatchedMessage;

  @override
  List<Object?> get props => [
        status,
        currentPassword,
        newPassword,
        confirmPassword,
        message,
        doesNotMatchedMessage,
        showCurrentPassword,
        shownewPassword,
        showConfirmPassword,
      ];

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    String? message,
    Password? currentPassword,
    Password? newPassword,
    Password? confirmPassword,
    bool? showCurrentPassword,
    bool? shownewPassword,
    bool? showConfirmPassword,
    String? doesNotMatchedMessage,
  }) {
    return ChangePasswordState._(
      status: status ?? this.status,
      message: message ?? this.message,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      shownewPassword: shownewPassword ?? this.shownewPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      doesNotMatchedMessage:
          doesNotMatchedMessage ?? this.doesNotMatchedMessage,
    );
  }
}
