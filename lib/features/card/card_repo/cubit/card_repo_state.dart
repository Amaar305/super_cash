// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_repo_cubit.dart';

enum CardRepoStatus {
  initail,
  loading,
  success,
  failure;

  bool get isError => this == CardRepoStatus.failure;
  bool get isLoading => this == CardRepoStatus.loading;
}

class CardRepoState extends Equatable {
  final CardRepoStatus status;
  final DollarRate? dollarRate;
  final String message;

  const CardRepoState({
    required this.status,
    required this.dollarRate,
    required this.message,
  });

  const CardRepoState.initail()
      : this(
          dollarRate: null,
          status: CardRepoStatus.initail,
          message: '',
        );
  @override
  List<Object?> get props => [
        status,
        dollarRate,
        message,
      ];

  CardRepoState copyWith({
    CardRepoStatus? status,
    DollarRate? dollarRate,
    String? message,
  }) {
    return CardRepoState(
      status: status ?? this.status,
      dollarRate: dollarRate ?? this.dollarRate,
      message: message ?? this.message,
    );
  }
}
