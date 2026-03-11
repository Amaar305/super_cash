part of 'giveaway_winners_cubit.dart';

enum GiveawayWinnersStatus {
  initail,
  loading,
  success,
  failure;

  bool get isInitial => this == GiveawayWinnersStatus.initail;
  bool get isLoading => this == GiveawayWinnersStatus.loading;
  bool get isSuccess => this == GiveawayWinnersStatus.success;
  bool get isFailure => this == GiveawayWinnersStatus.failure;
}

class GiveawayWinnersState extends Equatable {
  final GiveawayWinnersStatus status;
  final String? message;
  final List<GiveawayWinner> winners;
  final String? filter;

  const GiveawayWinnersState._({
    required this.status,
    required this.message,
    required this.winners,
    required this.filter,
  });

  const GiveawayWinnersState.initial()
    : this._(
        status: GiveawayWinnersStatus.initail,
        message: null,
        winners: const [],
        filter: 'All Categories',
      );

  List<GiveawayWinner> get filteredWinners {
    if (filter == null) {
      return winners;
    }
    switch (filter) {
      case 'All Categories':
        return winners;
      case 'Airtime':
        return winners
            .where((winner) => winner.type.code.contains('airtime'))
            .toList();

      case 'Data':
        return winners
            .where((winner) => winner.type.code.contains('data'))
            .toList();
      default:
        return winners;
    }
  }

  GiveawayWinnersState copyWith({
    GiveawayWinnersStatus? status,
    String? message,
    List<GiveawayWinner>? winners,
    String? filter,
  }) {
    return GiveawayWinnersState._(
      status: status ?? this.status,
      message: message ?? this.message,
      winners: winners ?? this.winners,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [status, message, winners, filter];
}
