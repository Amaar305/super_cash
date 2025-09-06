// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_password_cubit.dart';

enum ChangePasswordStatus {
  initial,
  loading,
  success,
  error;

  bool get isSuccess => this == ChangePasswordStatus.success;
  bool get isLoading => this == ChangePasswordStatus.loading;
  bool get isError => this == ChangePasswordStatus.error;
}

class ChangePasswordState extends Equatable {
  const ChangePasswordState._({
    required this.status,
    required this.confirmPassword,
    required this.password,
    required this.showConfirmPassword,
    required this.showPassword,
    required this.otp,
    required this.message,
    required this.response,
    required this.confirmPasswordError,
  });

  const ChangePasswordState.initial()
      : this._(
          status: ChangePasswordStatus.initial,
          confirmPassword: const Password.pure(),
          password: const Password.pure(),
          showConfirmPassword: false,
          showPassword: false,
          otp: const Otp2.pure(),
          message: '',
          confirmPasswordError: null,
response: null,        );

  final ChangePasswordStatus status;
  final Password password;
  final Password confirmPassword;
  final Otp2 otp;
  final bool showPassword;
  final bool showConfirmPassword;
  final String message;
  final String? confirmPasswordError;
  final Map? response;

  @override
  List<Object> get props => [
        status,
        password,
        showPassword,
        showConfirmPassword,
        confirmPassword,
        otp,
      ];

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    Password? password,
    Password? confirmPassword,
    Otp2? otp,
    bool? showPassword,
    bool? showConfirmPassword,
    String? message,
    String? confirmPasswordError,
    Map? response,
  }) {
    return ChangePasswordState._(
      status: status ?? this.status,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      otp: otp ?? this.otp,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      message: message ?? this.message,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      response: response ?? this.response,
    );
  }
}

final changePasswordStatusMessage =
    <ChangePasswordStatus, SubmissionStatusMessage>{
  ChangePasswordStatus.error: const SubmissionStatusMessage.genericError(),
  // ChangePasswordStatus.invalidOtp: const SubmissionStatusMessage(
  //   title: 'Invalid OTP. Please check and re-enter the code.',
  // ),
};
