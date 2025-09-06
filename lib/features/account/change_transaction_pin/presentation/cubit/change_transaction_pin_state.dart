part of 'change_transaction_pin_cubit.dart';

enum ChangeTransactionPinStatus {
  initial,
  loading,
  success,
  failure;

  bool get isFailure => this == ChangeTransactionPinStatus.failure;
  bool get isLoading => this == ChangeTransactionPinStatus.loading;
  bool get isSuccess => this == ChangeTransactionPinStatus.success;
}

class ChangeTransactionPinState extends Equatable {
  final ChangeTransactionPinStatus status;
  final Otp currentPin;
  final Otp newPin;
  final Otp confirmPin;
  final String message;
  final String? confirmPinMessage;

  const ChangeTransactionPinState._({
    required this.status,
    required this.currentPin,
    required this.newPin,
    required this.confirmPin,
    required this.message,
    this.confirmPinMessage,
  });

  const ChangeTransactionPinState.initial()
    : this._(
        status: ChangeTransactionPinStatus.initial,
        currentPin: const Otp.pure(),
        newPin: const Otp.pure(),
        confirmPin: const Otp.pure(),
        message: '',
      );

  @override
  List<Object?> get props => [status, currentPin, newPin, confirmPin, message, confirmPinMessage,
  ];

  ChangeTransactionPinState copyWith({
    ChangeTransactionPinStatus? status,
    Otp? currentPin,
    Otp? newPin,
    Otp? confirmPin,
    String? message,
    String? confirmPinMessage,
  }) {
    return ChangeTransactionPinState._(
      status: status ?? this.status,
      currentPin: currentPin ?? this.currentPin,
      newPin: newPin ?? this.newPin,
      confirmPin: confirmPin ?? this.confirmPin,
      message: message ?? this.message,
      confirmPinMessage: confirmPinMessage ?? this.confirmPinMessage,
    );
  }
}
