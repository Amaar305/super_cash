part of 'giveaway_detail_cubit.dart';

enum GiveawayDetailStatus {
  initial,
  loading,
  eligible,
  notEligible,
  failure;

  bool get isLoading => this == GiveawayDetailStatus.loading;
  bool get isEligible => this == GiveawayDetailStatus.eligible;
  bool get isNotEligible => this == GiveawayDetailStatus.notEligible;
  bool get isFailure => this == GiveawayDetailStatus.failure;
}

class GiveawayDetailState extends Equatable {
  const GiveawayDetailState._({
    required this.status,
    required this.message,
    required this.shouldNavigateOnSuccess,
    this.result,
  });

  const GiveawayDetailState.initial()
    : this._(
        status: GiveawayDetailStatus.initial,
        message: '',
        shouldNavigateOnSuccess: false,
      );

  final GiveawayDetailStatus status;
  final String message;
  final bool shouldNavigateOnSuccess;
  final GiveawayEligibilityResult? result;

  GiveawayDetailState copyWith({
    GiveawayDetailStatus? status,
    String? message,
    bool? shouldNavigateOnSuccess,
    GiveawayEligibilityResult? result,
  }) {
    return GiveawayDetailState._(
      status: status ?? this.status,
      message: message ?? this.message,
      shouldNavigateOnSuccess:
          shouldNavigateOnSuccess ?? this.shouldNavigateOnSuccess,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [status, message, shouldNavigateOnSuccess, result];
}
