part of 'giveaway_cubit.dart';

enum GiveawayStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == GiveawayStatus.loading;
  bool get isSuccess => this == GiveawayStatus.success;
  bool get isFailure => this == GiveawayStatus.failure;
}

class GiveawayState extends Equatable {
  final GiveawayStatus status;
  final List<GiveawayType> types;
  final List<Giveaway> giveaways;
  final String? errorMessage;
  final UpcomingGiveawayStatus? selectedStatus;

  const GiveawayState._({
    required this.status,
    required this.types,
    required this.giveaways,
    required this.errorMessage,
    required this.selectedStatus,
  });

  const GiveawayState.initial()
    : this._(
        status: GiveawayStatus.initial,
        types: const [],
        giveaways: const [],
        errorMessage: null,
        selectedStatus: UpcomingGiveawayStatus.ongoing,
      );

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    types,
    giveaways,
    selectedStatus,
  ];

  List<Giveaway> get upcomingGiveaways => giveaways
      .where((element) => element.status == UpcomingGiveawayStatus.upcoming)
      .toList();

  List<Giveaway> get otherGiveaways =>
      giveaways.where((element) => element.status == selectedStatus).toList();

  GiveawayState copyWith({
    GiveawayStatus? status,
    List<GiveawayType>? types,
    List<Giveaway>? giveaways,
    UpcomingGiveawayStatus? selectedStatus,
    String? errorMessage,
  }) {
    return GiveawayState._(
      status: status ?? this.status,
      types: types ?? this.types,
      giveaways: giveaways ?? this.giveaways,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
