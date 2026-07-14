part of 'kyc_government_id_cubit.dart';

enum KycGovernmentIdStatus {
  initial,
  loading,
  uploading,
  success,
  uploaded,
  failure;

  bool get isInitial => this == KycGovernmentIdStatus.initial;
  bool get isLoading => this == KycGovernmentIdStatus.loading;
  bool get isUploading => this == KycGovernmentIdStatus.uploading;
  bool get isSuccess => this == KycGovernmentIdStatus.success;
  bool get isUploaded => this == KycGovernmentIdStatus.uploaded;
  bool get isFailure => this == KycGovernmentIdStatus.failure;
}

class KycGovernmentIdState extends Equatable {
  final KycGovernmentIdStatus status;
  final String message;
  final KycDocumentsListResponse? documentsListResponse;
  final String? selectedDocumentType;
  final String? selectedDocumentTypeError;
  final String documentNumber;
  final String? documentNumberError;
  final File? documentImageFile;
  final String? documentImageError;

  const KycGovernmentIdState._({
    required this.status,
    required this.message,
    this.documentsListResponse,
    this.selectedDocumentType,
    this.selectedDocumentTypeError,
    this.documentNumber = '',
    this.documentNumberError,
    this.documentImageFile,
    this.documentImageError,
  });

  const KycGovernmentIdState.initial()
      : this._(
          status: KycGovernmentIdStatus.initial,
          message: '',
        );

  KycDocumentData? get existingDocument =>
      (documentsListResponse?.data.isNotEmpty ?? false)
          ? documentsListResponse!.data.first
          : null;

  bool get alreadySubmitted => existingDocument != null;

  String? get displayImageUrl => existingDocument?.imageUrl;

  @override
  List<Object?> get props => [
        status,
        message,
        documentsListResponse,
        selectedDocumentType,
        selectedDocumentTypeError,
        documentNumber,
        documentNumberError,
        documentImageFile,
        documentImageError,
      ];

  KycGovernmentIdState copyWith({
    KycGovernmentIdStatus? status,
    String? message,
    KycDocumentsListResponse? documentsListResponse,
    String? selectedDocumentType,
    String? selectedDocumentTypeError,
    String? documentNumber,
    String? documentNumberError,
    File? documentImageFile,
    String? documentImageError,
    bool clearSelectedDocumentType = false,
    bool clearSelectedDocumentTypeError = false,
    bool clearDocumentNumberError = false,
    bool clearDocumentImageFile = false,
    bool clearDocumentImageError = false,
  }) {
    return KycGovernmentIdState._(
      status: status ?? this.status,
      message: message ?? this.message,
      documentsListResponse:
          documentsListResponse ?? this.documentsListResponse,
      selectedDocumentType: clearSelectedDocumentType
          ? null
          : (selectedDocumentType ?? this.selectedDocumentType),
      selectedDocumentTypeError: clearSelectedDocumentTypeError
          ? null
          : (selectedDocumentTypeError ?? this.selectedDocumentTypeError),
      documentNumber: documentNumber ?? this.documentNumber,
      documentNumberError: clearDocumentNumberError
          ? null
          : (documentNumberError ?? this.documentNumberError),
      documentImageFile: clearDocumentImageFile
          ? null
          : (documentImageFile ?? this.documentImageFile),
      documentImageError: clearDocumentImageError
          ? null
          : (documentImageError ?? this.documentImageError),
    );
  }
}
