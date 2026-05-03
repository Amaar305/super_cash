part of '../pages/product_giveaway_details_page.dart';

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().startsWith('http')) {
      return Align(
        alignment: Alignment.centerRight,
        child: Transform.translate(
          offset: const Offset(30, 6),
          child: SizedBox(
            width: 170,
            height: 150,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _fallback(),
            ),
          ),
        ),
      );
    }

    return _fallback();
  }

  Widget _fallback() {
    return Align(
      alignment: Alignment.centerRight,
      child: Opacity(
        opacity: 0.24,
        child: Transform.translate(
          offset: const Offset(20, 8),
          child: Assets.images.mtn.image(fit: BoxFit.cover),
        ),
      ),
    );
  }
}
