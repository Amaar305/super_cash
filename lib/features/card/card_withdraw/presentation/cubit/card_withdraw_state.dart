// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_withdraw_cubit.dart';

enum CardWithdrawStatus {
  initial,
  loading,
  success,
  failure;

  bool get isError => this == CardWithdrawStatus.failure;
  bool get isSuccess => this == CardWithdrawStatus.success;
  bool get isLoading => this == CardWithdrawStatus.loading;
}

class CardWithdrawState extends Equatable {
  final CardWithdrawStatus status;
  final String message;
  final Amount amount;
  final Wallet wallet;

  const CardWithdrawState._({
    required this.status,
    required this.message,
    required this.amount,
    required this.wallet,
  });

  const CardWithdrawState.initial()
      : this._(
          status: CardWithdrawStatus.initial,
          message: '',
          amount: const Amount.pure(),
          wallet: const Wallet.anonymous(),
        );

  @override
  List<Object> get props => [
        amount,
        status,
        message,
        wallet,
      ];

  CardWithdrawState copyWith({
    CardWithdrawStatus? status,
    String? message,
    Amount? amount,
    Wallet? wallet,
  }) {
    return CardWithdrawState._(
      status: status ?? this.status,
      message: message ?? this.message,
      amount: amount ?? this.amount,
      wallet: wallet ?? this.wallet,
    );
  }
}
