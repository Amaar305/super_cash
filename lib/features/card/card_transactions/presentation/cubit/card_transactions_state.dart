// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_transactions_cubit.dart';

enum CardTransactionsStatus {
  initial,
  loading,
  success,
  suspended,
  failure;

  bool get isInitial => this == CardTransactionsStatus.initial;
  bool get isLoading => this == CardTransactionsStatus.loading;
  bool get isSuccess => this == CardTransactionsStatus.success;
  bool get isSuspended => this == CardTransactionsStatus.suspended;
  bool get isFailure => this == CardTransactionsStatus.failure;
}

@JsonSerializable()
class CardTransactionsState extends Equatable {
  final CardTransactionsStatus status;
  final List<CardTransaction> transactions;
  final List<CardTransaction> data;
  final String message;
  final PaginationMeta? paginationMeta;
  final bool hasReachedMax;
  final bool isSortAsc;
  final String? nextPageUrl;

  const CardTransactionsState({
    required this.status,
    required this.transactions,
    required this.data,
    required this.message,
    required this.isSortAsc,
    this.paginationMeta,
    this.hasReachedMax = false,
    this.nextPageUrl,
  });

  const CardTransactionsState.initial()
      : this(
          status: CardTransactionsStatus.initial,
          transactions: const [],
          data: const [],
          message: '',
          isSortAsc: true,
        );

  @override
  List<Object?> get props => [
        status,
        transactions,
        data,
        message,
        paginationMeta,
        hasReachedMax,
        nextPageUrl,
        isSortAsc,
      ];

  CardTransactionsState copyWith({
    CardTransactionsStatus? status,
    List<CardTransaction>? transactions,
    List<CardTransaction>? data,
    String? message,
    PaginationMeta? paginationMeta,
    bool? hasReachedMax,
    bool? isSortAsc,
    String? nextPageUrl,
  }) {
    return CardTransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      data: data ?? this.data,
      message: message ?? this.message,
      paginationMeta: paginationMeta ?? this.paginationMeta,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isSortAsc: isSortAsc ?? this.isSortAsc,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    );
  }

  factory CardTransactionsState.fromJson(Map<String, dynamic> json) =>
      _$CardTransactionsStateFromJson(json);
  Map<String, dynamic> toJson() => _$CardTransactionsStateToJson(this);
}
