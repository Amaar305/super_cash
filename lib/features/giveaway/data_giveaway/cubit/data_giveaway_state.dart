part of 'data_giveaway_cubit.dart';

enum DataGiveawayStatus {
  initial,
  loading,
  loaded,
  claimed,
  failure;

  bool get isLoading => this == DataGiveawayStatus.loading;
  bool get isFailure => this == DataGiveawayStatus.failure;
  bool get isClaimed => this == DataGiveawayStatus.claimed;
}

class DataGiveawayState extends Equatable {
  final DataGiveawayStatus status;
  final String message;
  final List<DataGiveawayItem> dataPlans;
  final Phone phone;
  final int selectedNetworkFilterIndex;

  const DataGiveawayState._({
    required this.status,
    required this.message,
    required this.dataPlans,
    required this.phone,
    required this.selectedNetworkFilterIndex,
  });

  DataGiveawayState.initial(AppUser user)
    : this._(
        status: DataGiveawayStatus.initial,
        message: '',
        dataPlans: const [],
        phone: Phone.pure(user.phone),
        selectedNetworkFilterIndex: 0,
      );

  List<DataGiveawayItem> get availablePlans =>
      dataPlans.where((data) => data.isAvailable).toList();

  List<DataGiveawayItem> get filteredPlans {
    final plans = availablePlans;
    return switch (selectedNetworkFilterIndex) {
      1 =>
        plans
            .where((item) => item.network.toLowerCase().contains('mtn'))
            .toList(),

      2 =>
        plans
            .where((item) => item.network.toLowerCase().contains('airtel'))
            .toList(),

      3 =>
        plans
            .where((item) => item.network.toLowerCase().contains('glo'))
            .toList(),

      4 =>
        plans
            .where((item) => item.network.toLowerCase().contains('9mobile'))
            .toList(),

      _ => plans,
    };
  }

  double get totalGB => availablePlans.fold(0, (previousValue, item) {
    final size = double.tryParse(item.dataSize) ?? 0;
    return (size * item.dataQuantity) + previousValue;
  });
  double get availableGB => availablePlans.fold(0, (previousValue, item) {
    final size = double.tryParse(item.dataSize) ?? 0;
    return (size * item.dataQuantityRemaining) + previousValue;
  });

  double get remainingPercent {
    var total = totalGB;
    var remaining = availableGB;

    return total == 0 ? 0 : (remaining / total) * 100;
  }

  DataGiveawayState copyWith({
    DataGiveawayStatus? status,
    String? message,
    List<DataGiveawayItem>? dataPlans,
    Phone? phone,
    int? selectedNetworkFilterIndex,
  }) {
    return DataGiveawayState._(
      status: status ?? this.status,
      message: message ?? this.message,
      dataPlans: dataPlans ?? this.dataPlans,
      phone: phone ?? this.phone,
      selectedNetworkFilterIndex:
          selectedNetworkFilterIndex ?? this.selectedNetworkFilterIndex,
    );
  }

  @override
  List<Object?> get props => [
    status,
    dataPlans,
    message,
    phone,
    selectedNetworkFilterIndex,
  ];
}
