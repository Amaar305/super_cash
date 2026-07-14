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
  final CardFeeSettings? cardFeeSettings;
  final String message;

  const CardRepoState({
    required this.status,
    required this.cardFeeSettings,
    required this.message,
  });

  const CardRepoState.initail()
      : this(
          cardFeeSettings: null,
          status: CardRepoStatus.initail,
          message: '',
        );
  @override
  List<Object?> get props => [
        status,
        cardFeeSettings,
        message,
      ];

  CardRepoState copyWith({
    CardRepoStatus? status,
    CardFeeSettings? cardFeeSettings,
    String? message,
  }) {
    return CardRepoState(
      status: status ?? this.status,
      cardFeeSettings: cardFeeSettings ?? this.cardFeeSettings,
      message: message ?? this.message,
    );
  }
}
