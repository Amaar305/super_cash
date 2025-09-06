// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'electricity_cubit.dart';

enum ElectricityStatus {
  initial,
  loading,
  success,
  failure;

  bool get isError => this == ElectricityStatus.failure;
  bool get isSucsess => this == ElectricityStatus.success;
  bool get isLoading => this == ElectricityStatus.loading;
}

class ElectricityState extends Equatable {
  final ElectricityStatus status;
  final ElectricityPlan plans;
  final Amount amount;
  final Decoder meter;
  final Phone phone;
  final Electricity? selectedPlan;
  final String message;
  final bool prepaid;

  const ElectricityState._({
    required this.status,
    required this.plans,
    required this.amount,
    required this.meter,
    required this.phone,
    required this.selectedPlan,
    required this.message,
    required this.prepaid,
  });

  const ElectricityState.initial()
      : this._(
          status: ElectricityStatus.initial,
          plans: const ElectricityPlan.initial(),
          amount: const Amount.pure(),
          meter: const Decoder.pure(),
          phone: const Phone.pure(),
          selectedPlan: null,
          message: '',
          prepaid: true,
        );
  @override
  List<Object?> get props => [
        status,
        plans,
        amount,
        meter,
        phone,
        selectedPlan,
        message,
        prepaid,
      ];

  ElectricityState copyWith({
    ElectricityStatus? status,
    ElectricityPlan? plans,
    Amount? amount,
    Decoder? meter,
    Phone? phone,
    Electricity? selectedPlan,
    String? message,
    bool? prepaid,
  }) {
    return ElectricityState._(
      status: status ?? this.status,
      plans: plans ?? this.plans,
      amount: amount ?? this.amount,
      meter: meter ?? this.meter,
      phone: phone ?? this.phone,
      selectedPlan: selectedPlan ?? this.selectedPlan,
      message: message ?? this.message,
      prepaid: prepaid ?? this.prepaid,
    );
  }
}
