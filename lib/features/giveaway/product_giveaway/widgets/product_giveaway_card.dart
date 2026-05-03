import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ProductGiveawayCard extends StatelessWidget {
  const ProductGiveawayCard({
    super.key,
    required this.product,
    required this.onSuccessfulClaimed,
  });

  final ProductGiveawayModel product;
  final ValueChanged<ProductGiveawayModel> onSuccessfulClaimed;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ProductGiveawayCubit c) => c.state.status.isLoading,
    );
    return _ProductShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroCard(image: product.image),
          Gap.v(AppSpacing.lg),
          _ProductDetails(product: product),
          Gap.v(AppSpacing.md),
          _ProductQualityPercent(product: product),
          Gap.v(AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: ProductClaimButton(
              isLoading: isLoading,
              onClaimed: () => context
                  .read<ProductGiveawayCubit>()
                  .claimProduct(product.id, onSuccessfulClaimed),
              isDisabled: product.outOfStock || !product.isAvailable,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductClaimButton extends StatelessWidget {
  const ProductClaimButton({
    super.key,
    this.isDisabled = false,
    required this.onClaimed,
    required this.isLoading,
  });
  final bool isDisabled;
  final bool isLoading;

  final VoidCallback onClaimed;

  @override
  Widget build(BuildContext context) {

    return PrimaryButton(
      isLoading: isLoading,
      onPressed: onClaimed,
      label: isDisabled ? 'Out of stock' : 'Claim Now',
    );
  }
}

class _ProductQualityPercent extends StatelessWidget {
  const _ProductQualityPercent({required this.product});

  final ProductGiveawayModel product;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.deepBlue;

    final double progress =
        (product.productQuantity - product.productQuantityRemaining) /
        product.productQuantity;
    final qp = (progress * 100).toStringAsFixed(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.sm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$qp% FULL',
              style: poppinsTextStyle(
                fontSize: 11,
                fontWeight: AppFontWeight.semiBold,
                color: color,
              ),
            ),
            Text(
              '${product.productQuantityRemaining} left of ${product.productQuantity}',
              style: poppinsTextStyle(
                fontSize: 11,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppSpacing.sm,
          width: double.infinity,
          child: LinearProgressIndicator(
            value: progress,
            borderRadius: BorderRadius.circular(9999),
            color: color,
            backgroundColor: AppColors.brightGrey,
          ),
        ),
      ],
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.product});

  final ProductGiveawayModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.productName,
          style: poppinsTextStyle(
            fontSize: 20,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        Text(
          product.productDescription,
          style: poppinsTextStyle(
            fontSize: 12,
            fontWeight: AppFontWeight.light,
            color: AppColors.black,
          ).copyWith(height: 1),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: product.productSpecification
              .map(
                (e) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 176, 216, 235),
                  ),
                  child: FittedBox(
                    child: Text(
                      e,
                      style: poppinsTextStyle(
                        fontSize: 11,
                        fontWeight: AppFontWeight.medium,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        child: Image(image: NetworkImage(image), fit: BoxFit.cover),
      ),
    );
  }
}

class _ProductShell extends StatelessWidget {
  const _ProductShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xlg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.xlg),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withValues(alpha: 0.12),
            offset: Offset(0, 4),
            blurRadius: 32,
          ),
        ],
      ),
      child: child,
    );
  }
}
