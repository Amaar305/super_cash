// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cable_cubit.dart';

enum CableStatus {
  initial,
  loading,
  fetched,
  validated,
  success,
  failure;

  bool get isError => this == CableStatus.failure;
  bool get isLoading => this == CableStatus.loading;
  bool get isSuccess => this == CableStatus.success;
  bool get isFetched => this == CableStatus.fetched;
  bool get isValidated => this == CableStatus.validated;
}

class CableState extends Equatable {
  final CableStatus status;
  final String? selectedProvider;

  final String message;
  final String cardProvider;
  final Phone phone;
  final Decoder cardNumber;
  final Amount amount;
  final Map? plans;
  final Map? plan;

  const CableState._({
    required this.status,
    required this.message,
    required this.cardProvider,
    required this.phone,
    required this.cardNumber,
    required this.amount,
    required this.selectedProvider,
    required this.plans,
    required this.plan,
  });

  const CableState.initial()
    : this._(
        status: CableStatus.initial,
        message: '',
        cardProvider: '',
        phone: const Phone.pure(),
        cardNumber: const Decoder.pure(),
        amount: const Amount.pure(),
        selectedProvider: null,
        plans: null,
        plan: null,
      );

  @override
  List<Object?> get props => [
    status,
    message,
    cardProvider,
    phone,
    cardNumber,
    amount,
    selectedProvider,
    plans,
    plan,
  ];

  CableState copyWith({
    CableStatus? status,
    String? selectedProvider,
    String? message,
    String? cardProvider,
    Phone? phone,
    Decoder? cardNumber,
    Amount? amount,
    Map? plans,
    Map? plan,
    bool forcePlanD=false,
  }) {
    return CableState._(
      status: status ?? this.status,
      selectedProvider: selectedProvider ?? this.selectedProvider,
      message: message ?? this.message,
      cardProvider: cardProvider ?? this.cardProvider,
      phone: phone ?? this.phone,
      cardNumber: cardNumber ?? this.cardNumber,
      amount: amount ?? this.amount,
      plans: plans ?? this.plans,
      plan: forcePlanD ? null : plan ?? this.plan,
    );
  }
}
