// ignore_for_file: public_member_api_docs

class ImageSlider {
  ImageSlider({
    required this.imageUrl,
    this.link,
    this.isActive = false,
  });

  factory ImageSlider.fromJson(Map<String, dynamic> json) {
    return ImageSlider(
      imageUrl: json['image_url'] as String? ?? '',
      link: json['link'] as String?,
      isActive: json['is_active'] as bool? ?? false,
    );
  }
  final String imageUrl;
  final String? link;
  final bool isActive;

  bool get isValidUrl => imageUrl.isNotEmpty && imageUrl.startsWith('http');

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'link': link,
      'is_active': isActive,
    };
  }
}
