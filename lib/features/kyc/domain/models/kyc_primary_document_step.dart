class KycPrimaryDocumentStep {
  final bool complete;
  final String? type;
  final String? typeDisplay;
  final bool verified;

  const KycPrimaryDocumentStep({
    required this.complete,
    this.type,
    this.typeDisplay,
    this.verified = false,
  });

  factory KycPrimaryDocumentStep.fromJson(Map<String, dynamic> json) {
    return KycPrimaryDocumentStep(
      complete: json['complete'] as bool? ?? false,
      type: json['type'] as String?,
      typeDisplay: json['type_display'] as String?,
      verified: json['verified'] as bool? ?? false,
    );
  }
}
