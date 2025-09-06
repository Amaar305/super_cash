// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_card_pin_cubit.dart';

enum ChangeCardPinStatus {
  initial,
  loading,
  success,
  pinChanged,

  failure;

  bool get isError => this == ChangeCardPinStatus.failure;
  bool get isLoading => this == ChangeCardPinStatus.loading;
  bool get isSuccess => this == ChangeCardPinStatus.success;
  bool get isPinChanged => this == ChangeCardPinStatus.pinChanged;
}

class ChangeCardPinState extends Equatable {
  final ChangeCardPinStatus status;
  final Otp newCardPin;
  final Otp confirmCardPin;
  final String? confirmCardPinMessage;
  final String message;

  const ChangeCardPinState._({
    required this.confirmCardPin,
    required this.confirmCardPinMessage,
    required this.newCardPin,
    required this.message,
    required this.status,
  });

  const ChangeCardPinState.initial()
      : this._(
            confirmCardPin: const Otp.pure(),
            confirmCardPinMessage: null,
            newCardPin: const Otp.pure(),
            message: '',
            status: ChangeCardPinStatus.initial);

  @override
  List<Object?> get props => [
        confirmCardPin,
        confirmCardPinMessage,
        newCardPin,
        message,
      ];

  ChangeCardPinState copyWith({
    ChangeCardPinStatus? status,
    Otp? newCardPin,
    Otp? confirmCardPin,
    String? confirmCardPinMessage,
    String? message,
  }) {
    return ChangeCardPinState._(
      status: status ?? this.status,
      newCardPin: newCardPin ?? this.newCardPin,
      confirmCardPin: confirmCardPin ?? this.confirmCardPin,
      confirmCardPinMessage:
          confirmCardPinMessage ?? this.confirmCardPinMessage,
      message: message ?? this.message,
    );
  }
}
