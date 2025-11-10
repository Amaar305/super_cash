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
  final String message;

  const ReferralTypeState._({
    required this.status,
    required this.isIndividual,
    required this.message,
  });

  const ReferralTypeState.inital()
    : this._(
        status: ReferralTypeStatus.initial,
        isIndividual: null,
        message: '',
      );

  @override
  List<Object?> get props => [status, isIndividual, message];

  ReferralTypeState copyWith({
    ReferralTypeStatus? status,
    bool? isIndividual,
    String? message,
  }) {
    return ReferralTypeState._(
      status: status ?? this.status,
      isIndividual: isIndividual ?? this.isIndividual,
      message: message ?? this.message,
    );
  }
}
