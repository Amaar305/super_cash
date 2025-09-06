part of 'fund_card_cubit.dart';

enum FundCardStatus {
  initial,
  loading,
  success,
  failure;

  bool get isError => this == FundCardStatus.failure;
  bool get isSucces => this == FundCardStatus.success;
  bool get isLoading => this == FundCardStatus.loading;
}

class FundCardState extends Equatable {
  final FundCardStatus status;
  final Amount amount;
  final String message;
  const FundCardState._({
    required this.status,
    required this.amount,
    required this.message,
  });

  const FundCardState.initial()
      : this._(
          status: FundCardStatus.initial,
          amount: const Amount.pure(),
          message: '',
        );
  @override
  List<Object> get props => [amount, status, message];

  FundCardState copyWith({
    FundCardStatus? status,
    Amount? amount,
    String? message,
  }) {
    return FundCardState._(
      status: status ?? this.status,
      amount: amount ?? this.amount,
      message: message ?? this.message,
    );
  }
}
