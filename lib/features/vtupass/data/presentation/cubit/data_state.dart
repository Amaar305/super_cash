part of 'data_cubit.dart';

enum DataStatus {
  initial,
  loading,
  success,
  purchased,
  failure;

  bool get isLoading => this == DataStatus.loading;
  bool get isError => this == DataStatus.failure;
  bool get isSuccess => this == DataStatus.success;
  bool get isPurchased => this == DataStatus.purchased;
}

@JsonSerializable()
class DataState extends Equatable {
  const DataState({
    required this.message,
    required this.phone,
    required this.selectedNetwork,
    required this.status,
    required this.dataPlans,
    required this.selectedDataType,
    required this.selectedIndex,
    required this.instantData,
    required this.selectedDuration,
  });

  const DataState.initial()
    : this(
        message: '',
        phone: const Phone.pure(),
        status: DataStatus.initial,
        dataPlans: const [],
        selectedNetwork: null,
        selectedDataType: null,
        selectedIndex: null,
        selectedDuration: 'all',
        instantData: true,
      );

  final DataStatus status;
  final List<DataPlan> dataPlans;

  final Phone phone;
  final String message;
  final String? selectedDataType;
  final String? selectedDuration;
  final int? selectedIndex;
  final String? selectedNetwork;
  final bool instantData;

  DataPlan? get selectedPlan {
    final index = selectedIndex;
    if (index == null) return null;
    final plans = filteredPlans;
    if (index < 0 || index >= plans.length) return null;
    return plans[index];
  }

  DataState resetChanges() {
    return DataState(
      message: message,
      phone: phone,
      selectedNetwork: selectedNetwork,
      status: status,
      dataPlans: dataPlans,
      selectedDataType: null,
      selectedIndex: null,
      instantData: instantData,
      selectedDuration: 'all',
    );
  }

  List<DataPlan> get filteredPlans {
    return _filterPlans(
      plans: dataPlans,
      selectedType: selectedDataType,
      duration: selectedDuration,
    );
  }

  List<String> get filteredDataTypes {
    return dataPlans.map((e) => e.planType).toSet().toList();
  }

  @override
  List<Object?> get props => [
    status,
    phone,
    message,
    selectedNetwork,
    selectedDataType,
    dataPlans,
    selectedIndex,
    selectedDuration,
    instantData,
    filteredPlans,
  ];
  factory DataState.fromJson(Map<String, dynamic> json) =>
      _$DataStateFromJson(json);
  Map<String, dynamic> toJson() => _$DataStateToJson(this);

  DataState copyWith({
    DataStatus? status,
    List<DataPlan>? dataPlans,
    Phone? phone,
    String? message,
    String? selectedDataType,
    String? selectedDuration,
    int? selectedIndex,
    String? selectedNetwork,
    bool? instantData,
  }) {
    return DataState(
      status: status ?? this.status,
      dataPlans: dataPlans ?? this.dataPlans,
      phone: phone ?? this.phone,
      message: message ?? this.message,
      selectedDataType: selectedDataType ?? this.selectedDataType,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedNetwork: selectedNetwork ?? this.selectedNetwork,
      instantData: instantData ?? this.instantData,
    );
  }

  List<DataPlan> _filterPlans({
    required List<DataPlan> plans,
    required String? selectedType,
    required String? duration,
  }) {
    final type = selectedType?.toLowerCase();
    final period = duration?.toLowerCase();

    return plans.where((plan) {
      final matchesType = type == null || plan.planType.toLowerCase() == type;

      final validity = int.tryParse(plan.planValidity.split(' ').first);

      if (period == null || period == 'all' || validity == null) {
        return matchesType;
      }
  
      final matchesDuration = switch (period) {
        'daily' => validity < 7,
        'weekly' => validity == 7,
        'monthly' => validity > 7 && validity <= 30,
        _ => validity > 1,
      };

      return matchesType && matchesDuration;
    }).toList();
  }
}
