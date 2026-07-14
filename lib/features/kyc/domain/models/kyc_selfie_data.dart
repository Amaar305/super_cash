class KycSelfieData {
  final int id;
  final bool hasImage;
  final String? imageUrl;
  final String createdAt;
  final String updatedAt;

  const KycSelfieData({
    required this.id,
    required this.hasImage,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KycSelfieData.fromJson(Map<String, dynamic> json) {
    return KycSelfieData(
      id: int.tryParse(json['id'].toString()) ?? 0,
      hasImage: json['has_image'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }
}
