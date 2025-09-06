// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'confirm_transaction_pin_cubit.dart';

enum ConfirmTransactionPinStatus {
  initial,
  success,
  loading,
  failure;

  bool get isError => this == ConfirmTransactionPinStatus.failure;
  bool get isLoading => this == ConfirmTransactionPinStatus.loading;
  bool get isSuccess => this == ConfirmTransactionPinStatus.success;
}

class ConfirmTransactionPinState extends Equatable {
  final ConfirmTransactionPinStatus status;
  final Otp pin;
  final String message;
  final ConfirmPin? confirmPin;

  const ConfirmTransactionPinState._({
    required this.message,
    required this.pin,
    required this.status,
    required this.confirmPin,
  });

  const ConfirmTransactionPinState.initial()
      : this._(
          message: '',
          pin: const Otp.pure(),
          status: ConfirmTransactionPinStatus.initial,
          confirmPin: null,
        );

  @override
  List<Object?> get props => [
        message,
        pin,
        status,
        confirmPin,
      ];

  ConfirmTransactionPinState copyWith({
    ConfirmTransactionPinStatus? status,
    Otp? pin,
    String? message,
    ConfirmPin? confirmPin,
  }) {
    return ConfirmTransactionPinState._(
      status: status ?? this.status,
      pin: pin ?? this.pin,
      message: message ?? this.message,
      confirmPin: confirmPin ?? this.confirmPin,
    );
  }
}
