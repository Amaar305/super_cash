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

  List<DataGiveawayItem> get filteredPlans {
    return switch (selectedNetworkFilterIndex) {
      1 =>
        dataPlans
            .where((item) => item.network.toLowerCase().contains('mtn'))
            .toList(),

      2 =>
        dataPlans
            .where((item) => item.network.toLowerCase().contains('airtel'))
            .toList(),

      3 =>
        dataPlans
            .where((item) => item.network.toLowerCase().contains('glo'))
            .toList(),

      4 =>
        dataPlans
            .where((item) => item.network.toLowerCase().contains('9mobile'))
            .toList(),

      _ => dataPlans,
    };
  }

  double get totalGB => dataPlans.fold(0, (previousValue, item) {
    final size = double.tryParse(item.dataSize) ?? 0;
    return (size * item.dataQuantity) + previousValue;
  });
  double get availableGB => dataPlans.fold(0, (previousValue, item) {
    final size = double.tryParse(item.dataSize) ?? 0;
    return (size * item.dataQuantityRemaining) + previousValue;
  });

  double get remainingPercent {
    var total = 0.0;
    var remaining = 0.0;

    for (final item in dataPlans) {
      final amount = double.tryParse(item.dataSize) ?? 1;
      total += amount * item.dataQuantity;
      remaining += amount * item.dataQuantityRemaining;
    }

    return total == 0 ? 0 : remaining / total;
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
