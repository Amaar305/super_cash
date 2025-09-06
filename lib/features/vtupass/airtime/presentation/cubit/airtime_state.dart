// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'airtime_cubit.dart';

enum AirtimeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isSuccess => this == AirtimeStatus.success;
  bool get isLoading => this == AirtimeStatus.loading;
  bool get isError => this == AirtimeStatus.failure;
}

class AirtimeState extends Equatable {
  const AirtimeState._({
    required this.amount,
    required this.message,
    required this.phone,
    required this.status,
    required this.selectedNetwork,
    required this.response,
    required this.vtuSell,
  });
  const AirtimeState.initial()
      : this._(
          amount: const Amount.pure(),
          message: '',
          phone: const Phone.pure(),
          status: AirtimeStatus.initial,
          selectedNetwork: null,
          vtuSell: true,
          response: null,
        );
  final AirtimeStatus status;
  final Amount amount;
  final Phone phone;
  final String message;
  final String? selectedNetwork;
  final TransactionResponse? response;
  final bool vtuSell;

  @override
  List<Object?> get props => [
        status,
        amount,
        phone,
        message,
        selectedNetwork,
        response,
        vtuSell,
      ];

  AirtimeState copyWith({
    AirtimeStatus? status,
    Amount? amount,
    Phone? phone,
    String? message,
    String? selectedNetwork,
    TransactionResponse? response,
    bool? vtuSell,
  }) {
    return AirtimeState._(
      status: status ?? this.status,
      amount: amount ?? this.amount,
      phone: phone ?? this.phone,
      message: message ?? this.message,
      selectedNetwork: selectedNetwork ?? this.selectedNetwork,
      response: response ?? this.response,
      vtuSell: vtuSell ?? this.vtuSell,
    );
  }
}
