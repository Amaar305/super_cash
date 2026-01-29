// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'save_update_beneficiary_cubit.dart';

enum SaveUpdateBeneficiaryStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == SaveUpdateBeneficiaryStatus.initial;
  bool get isLoading => this == SaveUpdateBeneficiaryStatus.loading;
  bool get isSuccess => this == SaveUpdateBeneficiaryStatus.success;
  bool get isFailure => this == SaveUpdateBeneficiaryStatus.failure;
}

class SaveUpdateBeneficiaryState extends Equatable {
  final SaveUpdateBeneficiaryStatus status;
  final String message;
  final Beneficiary? beneficiary;
  final FullName name;
  final Phone phone;
  final String? network;
  final String? networkErrorMsg;

  const SaveUpdateBeneficiaryState({
    required this.status,
    required this.message,
    required this.beneficiary,
    required this.name,
    required this.phone,
    this.network,
    this.networkErrorMsg,
  });

  @override
  List<Object?> get props => [
    status,
    message,
    beneficiary,
    name,
    phone,
    network,
    networkErrorMsg,
  ];

  SaveUpdateBeneficiaryState.initial({Beneficiary? beneficiary})
    : this(
        status: SaveUpdateBeneficiaryStatus.initial,
        message: '',
        beneficiary: beneficiary,
        name: FullName.pure(beneficiary?.name ?? ''),
        phone: Phone.pure(beneficiary?.phone ?? ''),
        network: _networkName(beneficiary?.network),
      );

  SaveUpdateBeneficiaryState copyWith({
    SaveUpdateBeneficiaryStatus? status,
    String? message,
    Beneficiary? beneficiary,
    FullName? name,
    Phone? phone,
    String? network,
    String? networkErrorMsg,
  }) {
    return SaveUpdateBeneficiaryState(
      status: status ?? this.status,
      message: message ?? this.message,
      beneficiary: beneficiary ?? this.beneficiary,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      network: network ?? this.network,
      networkErrorMsg: networkErrorMsg ?? this.networkErrorMsg,
    );
  }

  static String? _networkName(String? newtwork) {
    return newtwork == 'mtn'
        ? 'MTN'
        : newtwork == '9mobile'
        ? '9Mobile'
        : newtwork == 'airtel'
        ? 'Airtel'
        : newtwork == 'glo'
        ? 'Glo'
        : newtwork?.capitalize;
  }
}
