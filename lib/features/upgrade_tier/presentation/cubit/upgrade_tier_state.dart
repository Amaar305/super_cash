// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upgrade_tier_cubit.dart';

enum UpgradeTierStatus {
  initial,
  loading,
  inProgress,
  success,
  suspended,
  upgraded,
  failure;

  bool get isError => this == UpgradeTierStatus.failure;
  bool get isSuspended => this == UpgradeTierStatus.suspended;
  bool get isLoading => this == UpgradeTierStatus.loading;
  bool get isSuccess => this == UpgradeTierStatus.success;
  bool get isUpgraded => this == UpgradeTierStatus.upgraded;
}

class UpgradeTierState extends Equatable {
  final UpgradeTierStatus status;
  final int currentStep;
  final int totalStep;
  final String message;
  final FirstName firstName;
  final LastName lastName;
  final Email email;
  final Phone phone;
  final String? selectedCountry;
  final String? selectedCountryErrMsg;
  final String? selectedState;
  final String? selectedStateErrMsg;
  final City city;
  final PostalCode postalCode;
  final HouseAddress houseAddress;
  final HouseNumber houseNumber;
  final String selectedIdType;
  final Bvn bvn;
  final File? selfie;
  final String? selfieImageErrMsg;

  const UpgradeTierState._({
    required this.status,
    required this.currentStep,
    required this.totalStep,
    required this.message,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.selectedCountry,
    required this.selectedCountryErrMsg,
    required this.selectedState,
    required this.selectedStateErrMsg,
    required this.houseAddress,
    required this.houseNumber,
    required this.postalCode,
    required this.selectedIdType,
    required this.city,
    required this.bvn,
    required this.selfie,
    required this.selfieImageErrMsg,
  });

   UpgradeTierState.inital({required AppUser currentUser})
      : this._(
          status: UpgradeTierStatus.initial,
          currentStep: 1,
          totalStep: 3,
          message: '',
          email:  Email.pure(currentUser.email),
          firstName:  FirstName.pure(currentUser.firstName),
          lastName:  LastName.pure(currentUser.lastName),
          phone:  Phone.pure(currentUser.phone),
          selectedCountry: null,
          selectedCountryErrMsg: null,
          selectedState: null,
          selectedStateErrMsg: null,
          houseAddress: const HouseAddress.pure(),
          houseNumber: const HouseNumber.pure(),
          postalCode: const PostalCode.pure(),
          selectedIdType: 'BVN',
          city: const City.pure(),
          bvn: const Bvn.pure(),
          selfie: null,
          selfieImageErrMsg: '',
        );
  @override
  List<Object?> get props => [
        status,
        currentStep,
        totalStep,
        message,
        email,
        firstName,
        lastName,
        phone,
        selectedCountry,
        selectedCountryErrMsg,
        selectedState,
        selectedStateErrMsg,
        houseAddress,
        houseNumber,
        postalCode,
        selectedIdType,
        city,
        bvn,
        selfie,
        selfieImageErrMsg,
      ];

  bool get isIdBvn => selectedIdType == 'BVN';
  bool get isIdNIN => selectedIdType == 'NIN' && !isIdBvn;
  bool get isIdDriverLicence => !isIdNIN && !isIdBvn;

  UpgradeTierState copyWith({
    UpgradeTierStatus? status,
    int? currentStep,
    int? totalStep,
    String? message,
    FirstName? firstName,
    LastName? lastName,
    Email? email,
    Phone? phone,
    String? selectedCountry,
    String? selectedCountryErrMsg,
    String? selectedState,
    String? selectedStateErrMsg,
    City? city,
    PostalCode? postalCode,
    HouseAddress? houseAddress,
    HouseNumber? houseNumber,
    String? selectedIdType,
    Bvn? bvn,
    File? selfie,
    String? selfieImageErrMsg,
  }) {
    return UpgradeTierState._(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      totalStep: totalStep ?? this.totalStep,
      message: message ?? this.message,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCountryErrMsg:
          selectedCountryErrMsg ?? this.selectedCountryErrMsg,
      selectedState: selectedState ?? this.selectedState,
      selectedStateErrMsg: selectedStateErrMsg ?? this.selectedStateErrMsg,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      houseAddress: houseAddress ?? this.houseAddress,
      houseNumber: houseNumber ?? this.houseNumber,
      selectedIdType: selectedIdType ?? this.selectedIdType,
      bvn: bvn ?? this.bvn,
      selfie: selfie ?? this.selfie,
      selfieImageErrMsg: selfieImageErrMsg ?? this.selfieImageErrMsg,
    );
  }
}
