class KycSelfieStep {
  final bool complete;
  final String? imageUrl;

  const KycSelfieStep({required this.complete, this.imageUrl});

  factory KycSelfieStep.fromJson(Map<String, dynamic> json) {
    return KycSelfieStep(
      complete: json['complete'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
    );
  }
}
