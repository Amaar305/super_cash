// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    required this.filteredPlans,
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
          filteredPlans: const [],
          selectedNetwork: null,
          selectedDataType: null,
          selectedIndex: null,
          selectedDuration: 'all',
          instantData: true,
        );

  final DataStatus status;
  final List<DataPlan> dataPlans;
  final List<DataPlan> filteredPlans; // Display only filtered plans

  final Phone phone;
  final String message;
  final String? selectedDataType;
  final String? selectedDuration;
  final int? selectedIndex;
  final String? selectedNetwork;
  final bool instantData;

  DataState resetChanges() {
    return DataState(
      message: message,
      phone: phone,
      selectedNetwork: selectedNetwork,
      status: status,
      dataPlans: dataPlans,
      selectedDataType: null,
      filteredPlans: filteredPlans,
      selectedIndex: null,
      instantData: instantData,
      selectedDuration: 'all',
    );
  }

  @override
  List<Object?> get props => [
        status,
        phone,
        message,
        selectedNetwork,
        selectedDataType,
        dataPlans,
        filteredPlans,
        selectedIndex,
        selectedDuration,
        instantData,
      ];
  factory DataState.fromJson(Map<String, dynamic> json) =>
      _$DataStateFromJson(json);
  Map<String, dynamic> toJson() => _$DataStateToJson(this);
  
  DataState copyWith({
    DataStatus? status,
    List<DataPlan>? dataPlans,
    List<DataPlan>? filteredPlans,
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
      filteredPlans: filteredPlans ?? this.filteredPlans,
      phone: phone ?? this.phone,
      message: message ?? this.message,
      selectedDataType: selectedDataType ?? this.selectedDataType,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedNetwork: selectedNetwork ?? this.selectedNetwork,
      instantData: instantData ?? this.instantData,
    );
  }
}
