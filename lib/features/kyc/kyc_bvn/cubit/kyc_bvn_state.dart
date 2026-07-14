part of 'kyc_bvn_cubit.dart';

enum KycBvnStatus {
  initial,
  loading,
  submitting,
  success,
  submitted,
  failure;

  bool get isInitial => this == KycBvnStatus.initial;
  bool get isLoading => this == KycBvnStatus.loading;
  bool get isSubmitting => this == KycBvnStatus.submitting;
  bool get isSuccess => this == KycBvnStatus.success;
  bool get isSubmitted => this == KycBvnStatus.submitted;
  bool get isFailure => this == KycBvnStatus.failure;
}

class KycBvnState extends Equatable {
  final KycBvnStatus status;
  final String message;
  final KycBvnStatusResponse? bvnResponse;
  final String bvn;
  final String? bvnError;

  const KycBvnState._({
    required this.status,
    required this.message,
    this.bvnResponse,
    this.bvn = '',
    this.bvnError,
  });

  const KycBvnState.initial()
      : this._(
          status: KycBvnStatus.initial,
          message: '',
        );

  bool get alreadySubmitted => bvnResponse?.complete == true;

  @override
  List<Object?> get props => [status, message, bvnResponse, bvn, bvnError];

  KycBvnState copyWith({
    KycBvnStatus? status,
    String? message,
    KycBvnStatusResponse? bvnResponse,
    String? bvn,
    String? bvnError,
    bool clearBvnError = false,
  }) {
    return KycBvnState._(
      status: status ?? this.status,
      message: message ?? this.message,
      bvnResponse: bvnResponse ?? this.bvnResponse,
      bvn: bvn ?? this.bvn,
      bvnError: clearBvnError ? null : (bvnError ?? this.bvnError),
    );
  }
}
