// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reset_transaction_pin_cubit.dart';

enum ResetTransactionPinStatus {
  initial,
  loading,
  success,
  failure;

  bool get isFailure => this == ResetTransactionPinStatus.failure;
  bool get isLoading => this == ResetTransactionPinStatus.loading;
  bool get isSuccess => this == ResetTransactionPinStatus.success;
}

class ResetTransactionPinState extends Equatable {
  final ResetTransactionPinStatus status;
  final Otp newPin;
  final Otp confirmPin;
  final Password password;
  final String message;
  final String? confirmPinMessage;
  final bool showPassword;

  const ResetTransactionPinState._({
    required this.status,
    required this.newPin,
    required this.confirmPin,
    required this.message,
    required this.password,
    required this.showPassword,
    this.confirmPinMessage,

  });
  const ResetTransactionPinState.initial()
    : this._(
        status: ResetTransactionPinStatus.initial,
        newPin: const Otp.pure(),
        confirmPin: const Otp.pure(),
        message: '',
        password: const Password.pure(),
        showPassword: false,
      );
  @override
  List<Object?> get props => [
    status,
    newPin,
    confirmPin,
    message,
    confirmPinMessage,
    password,
    showPassword,
  ];

  ResetTransactionPinState copyWith({
    ResetTransactionPinStatus? status,
    Otp? newPin,
    Otp? confirmPin,
    Password? password,
    String? message,
    String? confirmPinMessage,
    bool? showPassword,
  }) {
    return ResetTransactionPinState._(
      status: status ?? this.status,
      newPin: newPin ?? this.newPin,
      confirmPin: confirmPin ?? this.confirmPin,
      password: password ?? this.password,
      message: message ?? this.message,
      confirmPinMessage: confirmPinMessage ?? this.confirmPinMessage,
      showPassword: showPassword??this.showPassword,
    );
  }
}
