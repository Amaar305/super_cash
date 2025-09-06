part of 'history_cubit.dart';

enum HistoryStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == HistoryStatus.loading;
  bool get isSuccess => this == HistoryStatus.success;
  bool get isError => this == HistoryStatus.failure;
}

@JsonSerializable()
class HistoryState extends Equatable {
  const HistoryState({
    required this.message,
    required this.status,
    required this.transactions,
    required this.data,
    this.hasReachedMax = false,
    required this.paginationMeta,
    required this.currentPage,
    this.nextPageUrl,
    this.start,
    this.end,
    this.transactionStatus,
    this.transactionType,
  });

  const HistoryState.initial()
      : this(
          message: '',
          status: HistoryStatus.initial,
          transactions: const [],
          data: const [],
          currentPage: 1,
          paginationMeta: null,
        );
  factory HistoryState.fromJson(Map<String, dynamic> json) =>
      _$HistoryStateFromJson(json);
  final HistoryStatus status;
  final List<TransactionResponse> transactions;
  final List<TransactionResponse> data;
  final String message;
  final PaginationMeta? paginationMeta;
  final bool hasReachedMax;
  final int currentPage;
  final String? nextPageUrl;

  final DateTime? start;
  final DateTime? end;
  final TransactionStatus? transactionStatus;
  final TransactionType? transactionType;

  @override
  List<Object?> get props => [
        message,
        status,
        transactions,
        data,
        hasReachedMax,
        paginationMeta,
        currentPage,
        nextPageUrl,
        start,
        end,
        transactionStatus,
        transactionType,
      ];

  HistoryState copyWith({
    HistoryStatus? status,
    List<TransactionResponse>? transactions,
    List<TransactionResponse>? data,
    String? message,
    PaginationMeta? paginationMeta,
    bool? hasReachedMax,
    int? currentPage,
    String? nextPageUrl,
    DateTime? start,
    DateTime? end,
    TransactionStatus? transactionStatus,
    TransactionType? transactionType,
  }) {
    return HistoryState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      data: data ?? this.data,
      message: message ?? this.message,
      paginationMeta: paginationMeta ?? this.paginationMeta,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      start: start ?? this.start,
      end: end ?? this.end,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      transactionType: transactionType ?? this.transactionType,
    );
  }

  Map<String, dynamic> toJson() => _$HistoryStateToJson(this);
}
