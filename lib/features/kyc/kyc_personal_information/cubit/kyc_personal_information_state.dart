part of 'kyc_personal_information_cubit.dart';

enum KycPersonalInformationStatus {
  initial,
  loading,
  submitting,
  success,
  submitted,
  failure;

  bool get isInitial => this == KycPersonalInformationStatus.initial;
  bool get isLoading => this == KycPersonalInformationStatus.loading;
  bool get isSubmitting => this == KycPersonalInformationStatus.submitting;
  bool get isSuccess => this == KycPersonalInformationStatus.success;
  bool get isSubmitted => this == KycPersonalInformationStatus.submitted;
  bool get isFailure => this == KycPersonalInformationStatus.failure;
}

class KycPersonalInformationState extends Equatable {
  final KycPersonalInformationStatus status;
  final String message;
  final KycPersonalInfoResponse? personalInfoResponse;
  final FirstName firstName;
  final LastName lastName;
  final String middleName;
  final String dateOfBirth;
  final String? dateOfBirthError;
  final String? gender;

  const KycPersonalInformationState._({
    required this.status,
    required this.message,
    required this.personalInfoResponse,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dateOfBirth,
    this.dateOfBirthError,
    this.gender,
  });

  KycPersonalInformationState.initial({
    String userFirstName = '',
    String userLastName = '',
  }) : this._(
          status: KycPersonalInformationStatus.initial,
          message: '',
          personalInfoResponse: null,
          firstName: FirstName.pure(userFirstName),
          lastName: LastName.pure(userLastName),
          middleName: '',
          dateOfBirth: '',
          dateOfBirthError: null,
          gender: null,
        );

  bool get alreadySubmitted => personalInfoResponse?.complete == true;

  KycPersonalInformationState copyWith({
    KycPersonalInformationStatus? status,
    String? message,
    KycPersonalInfoResponse? personalInfoResponse,
    FirstName? firstName,
    LastName? lastName,
    String? middleName,
    String? dateOfBirth,
    String? dateOfBirthError,
    String? gender,
    bool clearGender = false,
    bool clearDateOfBirthError = false,
  }) {
    return KycPersonalInformationState._(
      status: status ?? this.status,
      message: message ?? this.message,
      personalInfoResponse: personalInfoResponse ?? this.personalInfoResponse,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateOfBirthError: clearDateOfBirthError
          ? null
          : (dateOfBirthError ?? this.dateOfBirthError),
      gender: clearGender ? gender : (gender ?? this.gender),
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        personalInfoResponse,
        firstName,
        lastName,
        middleName,
        dateOfBirth,
        dateOfBirthError,
        gender,
      ];
}
