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
  final String? quickNetwork;
  final String? selectedType;
  final String? highAmount;

  const GiveawayHistoryState._({
    required this.status,
    required this.message,
    required this.data,
    required this.quickNetwork,
    required this.selectedType,
    required this.highAmount,
  });

  const GiveawayHistoryState.initial()
    : this._(
        status: GiveawayHistoryStatus.initial,
        message: null,
        data: const [],
        highAmount: null,
        quickNetwork: null,
        selectedType: null,
      );

  List<GiveawayHistory> get filteredData {
    List<GiveawayHistory> history = data;
    var net = quickNetwork?.toLowerCase();
    var type = selectedType?.toLowerCase();

    if (net != null) {
      history = data.where((h) => h.network.toLowerCase() == net).toList();
    }

    if (type != null) {
      switch (type) {
        case 'data':
          return history
              .where((h) => h.giveawayType.code.toLowerCase().contains('data'))
              .toList();

        case 'airtime':
          return history
              .where(
                (h) => h.giveawayType.code.toLowerCase().contains('airtime'),
              )
              .toList();
        case 'product':
          return history
              .where(
                (h) => h.giveawayType.code.toLowerCase().contains('product'),
              )
              .toList();

        default:
          return history;
      }
    } else {
      return history;
    }
  }

  int get totalRewards => data.length;
  double get totalAirtimeAmount => data.fold(0, (previousValue, element) {
    if (!element.giveawayType.code.contains('airtime')) {
      return previousValue;
    }
    return previousValue + double.parse(element.amount);
  });
  @override
  List<Object?> get props => [
    status,
    data,
    message,
    quickNetwork,
    selectedType,
    highAmount,
  ];

  GiveawayHistoryState copyWith({
    GiveawayHistoryStatus? status,
    String? message,
    List<GiveawayHistory>? data,
    String? quickNetwork,
    String? selectedType,
    String? highAmount,
  }) {
    return GiveawayHistoryState._(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
      highAmount: highAmount ?? this.highAmount,
      quickNetwork: quickNetwork ?? this.quickNetwork,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}
