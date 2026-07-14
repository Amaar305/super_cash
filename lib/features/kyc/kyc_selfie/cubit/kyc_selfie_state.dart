part of 'kyc_selfie_cubit.dart';

enum KycSelfieStatus {
  initial,
  loading,
  uploading,
  success,
  uploaded,
  failure;

  bool get isInitial => this == KycSelfieStatus.initial;
  bool get isLoading => this == KycSelfieStatus.loading;
  bool get isUploading => this == KycSelfieStatus.uploading;
  bool get isSuccess => this == KycSelfieStatus.success;
  bool get isUploaded => this == KycSelfieStatus.uploaded;
  bool get isFailure => this == KycSelfieStatus.failure;
}

class KycSelfieState extends Equatable {
  final KycSelfieStatus status;
  final String message;
  final File? selfieFile;
  final String? selfieError;
  final KycSelfieResponse? selfieResponse;

  const KycSelfieState._({
    required this.status,
    required this.message,
    this.selfieFile,
    this.selfieError,
    this.selfieResponse,
  });

  const KycSelfieState.initial()
      : this._(
          status: KycSelfieStatus.initial,
          message: '',
          selfieFile: null,
          selfieError: null,
          selfieResponse: null,
        );

  String? get displayImageUrl => selfieResponse?.data?.imageUrl;
  bool get alreadySubmitted => selfieResponse?.complete == true;

  KycSelfieState copyWith({
    KycSelfieStatus? status,
    String? message,
    File? selfieFile,
    String? selfieError,
    KycSelfieResponse? selfieResponse,
    bool clearSelfieFile = false,
    bool clearSelfieError = false,
  }) {
    return KycSelfieState._(
      status: status ?? this.status,
      message: message ?? this.message,
      selfieFile: clearSelfieFile ? null : (selfieFile ?? this.selfieFile),
      selfieError:
          clearSelfieError ? null : (selfieError ?? this.selfieError),
      selfieResponse: selfieResponse ?? this.selfieResponse,
    );
  }

  @override
  List<Object?> get props =>
      [status, message, selfieFile, selfieError, selfieResponse];
}
