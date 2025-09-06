// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_virtual_card_cubit.dart';

enum CreateVirtualCardStatus {
  initial,
  loading,
  success,
  process,
  failure;

  bool get isLoading => this == CreateVirtualCardStatus.loading;
  bool get isError => this == CreateVirtualCardStatus.failure;
  bool get isProcess => this == CreateVirtualCardStatus.process;
  bool get isSuccess => this == CreateVirtualCardStatus.success;
}

class CreateVirtualCardState extends Equatable {
  const CreateVirtualCardState._({
    required this.isMasterCard,
    required this.isUSDCard,
    required this.message,
    required this.status,
    required this.cardPin,
    required this.cardPinMessage,
    required this.confirmCardPin,
    required this.confirmCardPinMessage,
    required this.showPin,
    required this.amount,
    required this.platinum,
  });
  const CreateVirtualCardState.initial()
      : this._(
          isMasterCard: true,
          isUSDCard: true,
          message: '',
          status: CreateVirtualCardStatus.initial,
          amount: const Amount.pure(),
          cardPin: const Otp.pure(),
          confirmCardPin: const Otp.pure(),
          cardPinMessage: '',
          confirmCardPinMessage: '',
          showPin: false,
          platinum: false,
        );
  final CreateVirtualCardStatus status;
  final bool isUSDCard;
  final bool isMasterCard;
  final bool platinum;
  final String message;
  final Otp cardPin;
  final Otp confirmCardPin;
  final Amount amount;
  final String cardPinMessage;
  final String confirmCardPinMessage;
  final bool showPin;
  @override
  List<Object> get props => [
        isUSDCard,
        isMasterCard,
        message,
        status,
        amount,
        cardPin,
        confirmCardPin,
        cardPinMessage,
        confirmCardPinMessage,
        showPin,
        platinum,
      ];

  CreateVirtualCardState copyWith({
    CreateVirtualCardStatus? status,
    bool? isUSDCard,
    bool? isMasterCard,
    bool? platinum,
    String? message,
    Otp? cardPin,
    Otp? confirmCardPin,
    Amount? amount,
    String? cardPinMessage,
    String? confirmCardPinMessage,
    bool? showPin,
  }) {
    return CreateVirtualCardState._(
      status: status ?? this.status,
      isUSDCard: isUSDCard ?? this.isUSDCard,
      isMasterCard: isMasterCard ?? this.isMasterCard,
      platinum: platinum ?? this.platinum,
      message: message ?? this.message,
      cardPin: cardPin ?? this.cardPin,
      confirmCardPin: confirmCardPin ?? this.confirmCardPin,
      amount: amount ?? this.amount,
      cardPinMessage: cardPinMessage ?? this.cardPinMessage,
      confirmCardPinMessage: confirmCardPinMessage ?? this.confirmCardPinMessage,
      showPin: showPin ?? this.showPin,
    );
  }
}
