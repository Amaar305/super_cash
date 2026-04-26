import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class AddProductAddressPage extends StatelessWidget {
  const AddProductAddressPage({super.key, required this.product});
  final ProductGiveawayModel product;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap.v(AppSpacing.xlg),
            // Product image
            _ProduuctImage(product: product),
            Gap.v(AppSpacing.md),
            // Description
            _Description(product: product),
            Gap.v(AppSpacing.lg),
            // Form fields
            AddProductAddressForm(),
            Gap.v(AppSpacing.md),
            ProductAddressSaveButton(productId: product.id),
          ],
        ),
      ),
    );
  }
}

class _ProduuctImage extends StatelessWidget {
  const _ProduuctImage({required this.product});

  final ProductGiveawayModel product;

  @override
  Widget build(BuildContext context) {
   
    return SizedBox(
      width: 160,
      height: 122,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(AppSpacing.lg),
        child: Image(image: NetworkImage(product.image), fit: BoxFit.cover),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.product});

  final ProductGiveawayModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Congratulation!', style: context.titleMedium),
        Text(
          'You have successfully claimed ${product.productName}.\nPlease provide your shipping address for product delivery.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, fontWeight: AppFontWeight.extraLight),
        ),
      ],
    );
  }
}
