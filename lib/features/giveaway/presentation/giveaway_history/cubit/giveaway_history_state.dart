part of 'giveaway_history_cubit.dart';

enum GiveawayHistoryStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == GiveawayHistoryStatus.loading;
  bool get isSuccess => this == GiveawayHistoryStatus.success;
  bool get isFailure => this == GiveawayHistoryStatus.failure;
}

class GiveawayHistoryState extends Equatable {
  final GiveawayHistoryStatus status;
  final String? message;
  final List<GiveawayHistory> data;

  const GiveawayHistoryState._({
    required this.status,
    required this.message,
    required this.data,
  });

  const GiveawayHistoryState.initial()
    : this._(
        status: GiveawayHistoryStatus.initial,
        message: null,
        data: const [],
      );

  @override
  List<Object?> get props => [status, data, message];


  GiveawayHistoryState copyWith({
    GiveawayHistoryStatus? status,
    String? message,
    List<GiveawayHistory>? data,
  }) {
    return GiveawayHistoryState._(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
