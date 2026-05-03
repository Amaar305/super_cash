part of 'direct_airtime_giveaway_cubit.dart';

enum DirectAirtimeGiveawayStatus {
  initial,
  loading,
  loaded,
  claimed,
  submited,
  failure;

  bool get isLoading => this == DirectAirtimeGiveawayStatus.loading;
  bool get isFailure => this == DirectAirtimeGiveawayStatus.failure;
}

class DirectAirtimeGiveawayState extends Equatable {
  final DirectAirtimeGiveawayStatus status;
  final String message;
  final List<DirectAirtimeModel> airtimes;
  final Phone phone;
  final int selectedNetworkFilterIndex;

  const DirectAirtimeGiveawayState._({
    required this.status,
    required this.message,
    required this.airtimes,
    required this.phone,
    required this.selectedNetworkFilterIndex,
  });

  const DirectAirtimeGiveawayState.initial()
    : this._(
        status: DirectAirtimeGiveawayStatus.initial,
        message: '',
        airtimes: const [],
        phone: const Phone.pure(),
        selectedNetworkFilterIndex: 0,
      );

  List<DirectAirtimeModel> get filteredAirtimes {
    return switch (selectedNetworkFilterIndex) {
      1 =>
        airtimes
            .where((item) => item.network.toLowerCase().contains('mtn'))
            .toList(),

      2 =>
        airtimes
            .where((item) => item.network.toLowerCase().contains('airtel'))
            .toList(),

      3 =>
        airtimes
            .where((item) => item.network.toLowerCase().contains('glo'))
            .toList(),

      4 =>
        airtimes
            .where((item) => item.network.toLowerCase().contains('9mobile'))
            .toList(),

      _ => airtimes,
    };
  }

  int get totalAirtime {
    var total = 0;

    for (final item in airtimes) {
      total += ((double.tryParse(item.amount) ?? 0) * item.amountQuantity)
          .toInt();
    }

    return total;
  }

  int get availableAirtime {
    var total = 0;

    for (final item in airtimes) {
      total +=
          ((double.tryParse(item.amount) ?? 0) * item.amountQuantityRemaining)
              .toInt();
    }

    return total;
  }

  double get remainingPercent {
    var total = 0;
    var remaining = 0;

    for (final airtime in airtimes) {
      total += airtime.amountQuantity;
      remaining += airtime.amountQuantityRemaining;
    }

    return total == 0 ? 0 : remaining / total;
  }

  DirectAirtimeGiveawayState copyWith({
    DirectAirtimeGiveawayStatus? status,
    String? message,
    List<DirectAirtimeModel>? airtimes,
    Phone? phone,
    int? selectedNetworkFilterIndex,
  }) {
    return DirectAirtimeGiveawayState._(
      status: status ?? this.status,
      message: message ?? this.message,
      airtimes: airtimes ?? this.airtimes,
      phone: phone ?? this.phone,
      selectedNetworkFilterIndex:
          selectedNetworkFilterIndex ?? this.selectedNetworkFilterIndex,
    );
  }

  @override
  List<Object> get props => [
    status,
    message,
    airtimes,
    phone,
    selectedNetworkFilterIndex,
  ];
}
