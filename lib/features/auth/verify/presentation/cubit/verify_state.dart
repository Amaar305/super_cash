// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'verify_cubit.dart';

enum VerifyStatus {
  initial,
  loading,
  success,
  otpRequested,
  failure;

  bool get isError => this == VerifyStatus.failure;
  bool get isLoading => this == VerifyStatus.loading;
  bool get isOtpRequested => this == VerifyStatus.otpRequested;
  bool get isSuccess => this == VerifyStatus.success;
}

class VerifyState extends Equatable {
  final VerifyStatus status;
  final Otp otp;
  final String message;
  final Map? response;

  const VerifyState._({
    required this.status,
    required this.otp,
    required this.message,
    required this.response,
  });

  const VerifyState.initial()
    : this._(
        status: VerifyStatus.initial,
        otp: const Otp.pure(),
        message: '',
        response: null,
      );

  @override
  List<Object?> get props => [status, otp, message, response];

  VerifyState copyWith({
    VerifyStatus? status,
    Otp? otp,
    String? message,
    Map? response,
  }) {
    return VerifyState._(
      status: status ?? this.status,
      otp: otp ?? this.otp,
      message: message ?? this.message,
      response: response ?? this.response,
    );
  }
}
