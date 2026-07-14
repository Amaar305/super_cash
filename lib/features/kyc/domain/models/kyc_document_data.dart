class KycDocumentData {
  final int id;
  final String documentType;
  final String documentTypeDisplay;
  final String documentNumber;
  final String? imageUrl;
  final bool isVerified;
  final String createdAt;

  const KycDocumentData({
    required this.id,
    required this.documentType,
    required this.documentTypeDisplay,
    required this.documentNumber,
    this.imageUrl,
    required this.isVerified,
    required this.createdAt,
  });

  factory KycDocumentData.fromJson(Map<String, dynamic> json) {
    return KycDocumentData(
      id: int.tryParse(json['id'].toString()) ?? 0,
      documentType: json['document_type'] as String? ?? '',
      documentTypeDisplay: json['document_type_display'] as String? ?? '',
      documentNumber: json['document_number'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}
