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

  const DataGiveawayState._({
    required this.status,
    required this.message,
    required this.dataPlans,
    required this.phone,
  });

  DataGiveawayState.initial(AppUser user)
    : this._(
        status: DataGiveawayStatus.initial,
        message: '',
        dataPlans: const [],
        phone: Phone.pure(user.phone),
      );

  DataGiveawayState copyWith({
    DataGiveawayStatus? status,
    String? message,
    List<DataGiveawayItem>? dataPlans,
    Phone?phone
  }) {
    return DataGiveawayState._(
      status: status ?? this.status,
      message: message ?? this.message,
      dataPlans: dataPlans ?? this.dataPlans,
      phone: phone??this.phone,
    );
  }

  @override
  List<Object?> get props => [status, dataPlans, message, phone];
}
