part of 'kyc_home_address_cubit.dart';

enum KycHomeAddressStatus {
  initial,
  loading,
  submitting,
  success,
  submitted,
  failure;

  bool get isInitial => this == KycHomeAddressStatus.initial;
  bool get isLoading => this == KycHomeAddressStatus.loading;
  bool get isSubmitting => this == KycHomeAddressStatus.submitting;
  bool get isSuccess => this == KycHomeAddressStatus.success;
  bool get isSubmitted => this == KycHomeAddressStatus.submitted;
  bool get isFailure => this == KycHomeAddressStatus.failure;
}

class KycHomeAddressState extends Equatable {
  final KycHomeAddressStatus status;
  final String message;
  final KycAddressResponse? addressData;

  // Form fields
  final String country;
  final String? selectedState;
  final String? selectedStateError;
  final String? selectedLga;
  final City city;
  final String houseNo;
  final HouseAddress address;
  final String postalCode;

  const KycHomeAddressState._({
    required this.status,
    required this.message,
    required this.addressData,
    required this.country,
    this.selectedState,
    this.selectedStateError,
    this.selectedLga,
    required this.city,
    required this.houseNo,
    required this.address,
    required this.postalCode,
  });

  const KycHomeAddressState.initial()
      : this._(
          status: KycHomeAddressStatus.initial,
          message: '',
          addressData: null,
          country: 'Nigeria',
          selectedState: null,
          selectedStateError: null,
          selectedLga: null,
          city: const City.pure(),
          houseNo: '',
          address: const HouseAddress.pure(),
          postalCode: '',
        );

  bool get alreadySubmitted => addressData?.complete == true;

  KycHomeAddressState copyWith({
    KycHomeAddressStatus? status,
    String? message,
    KycAddressResponse? addressData,
    String? country,
    String? selectedState,
    String? selectedStateError,
    String? selectedLga,
    City? city,
    String? houseNo,
    HouseAddress? address,
    String? postalCode,
    bool clearSelectedState = false,
    bool clearSelectedStateError = false,
    bool clearSelectedLga = false,
  }) {
    return KycHomeAddressState._(
      status: status ?? this.status,
      message: message ?? this.message,
      addressData: addressData ?? this.addressData,
      country: country ?? this.country,
      selectedState: clearSelectedState
          ? selectedState
          : (selectedState ?? this.selectedState),
      selectedStateError: clearSelectedStateError
          ? null
          : (selectedStateError ?? this.selectedStateError),
      selectedLga:
          clearSelectedLga ? selectedLga : (selectedLga ?? this.selectedLga),
      city: city ?? this.city,
      houseNo: houseNo ?? this.houseNo,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        addressData,
        country,
        selectedState,
        selectedStateError,
        selectedLga,
        city,
        houseNo,
        address,
        postalCode,
      ];
}
