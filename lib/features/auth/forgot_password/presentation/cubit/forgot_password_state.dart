// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_cubit.dart';

enum ForgotPasswordStatus {
  initial,
  loading,
  success,
  failure,
  tooManyRequests;

  bool get isSuccess => this == ForgotPasswordStatus.success;
  bool get isLoading => this == ForgotPasswordStatus.loading;
  bool get isError => this == ForgotPasswordStatus.failure || isTooManyRequests;
  bool get isTooManyRequests => this == ForgotPasswordStatus.tooManyRequests;
}

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState._({
    required this.email,
    required this.status,
    required this.message,
    required this.response,
    required this.withEmail,
    required this.phone,
  });

  const ForgotPasswordState.initial()
      : this._(
          email: const Email.pure(),
          status: ForgotPasswordStatus.initial,
          message: '',
          response: null,
          phone: const Phone.pure(),
          withEmail: true,
        );
  final ForgotPasswordStatus status;
  final Email email;
  final Phone phone;
  final bool withEmail;
  final String message;
  final Map? response;

  @override
  List<Object?> get props => [
        status,
        email,
        response,
        phone,
        withEmail,
      ];

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    Email? email,
    Phone? phone,
    bool? withEmail,
    String? message,
    Map? response,
  }) {
    return ForgotPasswordState._(
      status: status ?? this.status,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      withEmail: withEmail ?? this.withEmail,
      message: message ?? this.message,
      response: response ?? this.response,
    );
  }
}

final forgotPasswordStatusMessage =
    <ForgotPasswordStatus, SubmissionStatusMessage>{
  ForgotPasswordStatus.failure: const SubmissionStatusMessage.genericError(),
  ForgotPasswordStatus.tooManyRequests: const SubmissionStatusMessage(
    title: 'Too many requests.',
    description: 'Please try again later.',
  ),
};
