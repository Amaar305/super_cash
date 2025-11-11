part of 'referral_type_cubit.dart';

enum ReferralTypeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == ReferralTypeStatus.initial;
  bool get isLoading => this == ReferralTypeStatus.loading;
  bool get isSuccess => this == ReferralTypeStatus.success;
  bool get isFailure => this == ReferralTypeStatus.failure;
}

class ReferralTypeState extends Equatable {
  final ReferralTypeStatus status;
  final bool? isIndividual;
  final ReferralTypeResult? referralTypeResult;
  final ReferralTypeModel? selectedCampaign;
  final bool termsContidition;
  final String message;

  const ReferralTypeState._({
    required this.status,
    required this.isIndividual,
    required this.message,
    this.referralTypeResult,
    this.selectedCampaign,
    this.termsContidition = false,
  });

  const ReferralTypeState.inital()
    : this._(
        status: ReferralTypeStatus.initial,
        isIndividual: null,
        message: '',
      );

  @override
  List<Object?> get props => [
    status,
    isIndividual,
    message,
    referralTypeResult,
    selectedCampaign,
    termsContidition,
  ];

  ReferralTypeState copyWith({
    ReferralTypeStatus? status,
    bool? isIndividual,
    String? message,
    ReferralTypeResult? referralTypeResult,
    ReferralTypeModel? selectedCampaign,
    bool? termsContidition,
  }) {
    return ReferralTypeState._(
      status: status ?? this.status,
      isIndividual: isIndividual ?? this.isIndividual,
      message: message ?? this.message,
      referralTypeResult: referralTypeResult ?? this.referralTypeResult,
      selectedCampaign: selectedCampaign ?? this.selectedCampaign,
      termsContidition: termsContidition ?? this.termsContidition,
    );
  }
}
