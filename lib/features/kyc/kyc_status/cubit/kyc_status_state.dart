part of 'kyc_status_cubit.dart';

enum KycStatusStatus {
  initial,
  loading,
  success,
  failure,
  registering,
  registered;

  bool get isInitial => this == KycStatusStatus.initial;
  bool get isLoading => this == KycStatusStatus.loading;
  bool get isFailure => this == KycStatusStatus.failure;
  bool get isSuccess => this == KycStatusStatus.success;
  bool get isRegistering => this == KycStatusStatus.registering;
  bool get isRegistered => this == KycStatusStatus.registered;
}

class KycStepItem {
  final int number;
  final String label;
  final String description;
  final bool complete;
  final bool hasMissingFields;

  const KycStepItem({
    required this.number,
    required this.label,
    required this.description,
    required this.complete,
    this.hasMissingFields = false,
  });
}

class KycStatusState extends Equatable {
  final KycStatusStatus status;
  final String message;
  final KycStatus? kycStatus;
  final KycCardholderResponse? cardholder;

  const KycStatusState._({
    required this.status,
    required this.message,
    required this.kycStatus,
    this.cardholder,
  });

  const KycStatusState.intial()
    : this._(status: KycStatusStatus.initial, message: '', kycStatus: null);

  @override
  List<Object?> get props => [status, message, kycStatus, cardholder];

  KycStatusState copyWith({
    KycStatusStatus? status,
    String? message,
    KycStatus? kycStatus,
    KycCardholderResponse? cardholder,
  }) {
    return KycStatusState._(
      status: status ?? this.status,
      message: message ?? this.message,
      kycStatus: kycStatus ?? this.kycStatus,
      cardholder: cardholder ?? this.cardholder,
    );
  }

  // ---------------------------------------------------------------------------
  // Computed — all logic lives here, zero logic in the page
  // ---------------------------------------------------------------------------

  List<KycStepItem> get stepItems {
    if (kycStatus == null) return const [];
    final steps = kycStatus!.steps;
    return [
      KycStepItem(
        number: 1,
        label: 'Personal Info',
        description: steps.personalInfo.complete
            ? 'Legal name and date of birth provided.'
            : 'Provide your legal name and date of birth.',
        complete: steps.personalInfo.complete,
      ),
      KycStepItem(
        number: 2,
        label: 'Home Address',
        description: steps.address.complete
            ? 'Primary residential address registered.'
            : 'Register your primary residential address.',
        complete: steps.address.complete,
        hasMissingFields: steps.address.missingFields.isNotEmpty,
      ),
      KycStepItem(
        number: 3,
        label: 'Selfie Photo',
        description: steps.selfie.complete
            ? 'Biometric face match verified.'
            : 'Upload a clear photo of your face.',
        complete: steps.selfie.complete,
      ),
      KycStepItem(
        number: 4,
        label: 'Government ID',
        description: steps.primaryDocument.complete
            ? 'Government ID uploaded successfully.'
            : 'Upload a valid Passport or Driver\'s License.',
        complete: steps.primaryDocument.complete,
      ),
      KycStepItem(
        number: 5,
        label: 'BVN',
        description: steps.bvn.complete
            ? 'Bank Verification Number connected.'
            : 'Connect your Bank Verification Number.',
        complete: steps.bvn.complete,
      ),
    ];
  }

  int get completedStepsCount => stepItems.where((s) => s.complete).length;
  int get totalSteps => 5;
  double get progressValue =>
      totalSteps == 0 ? 0.0 : completedStepsCount / totalSteps;
  bool get canActivate =>
      (kycStatus?.readyForCardRegistration ?? false) &&
      completedStepsCount == totalSteps;
  String get progressLabel =>
      '$completedStepsCount of $totalSteps steps completed';
}
