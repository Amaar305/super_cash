import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ProductAddressSaveButton extends StatelessWidget {
  const ProductAddressSaveButton({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ProductGiveawayCubit c) => c.state.status.isLoading,
    );

    return PrimaryButton(
      isLoading: isLoading,
      label: 'Save & Continue',
      onPressed: () => context.read<ProductGiveawayCubit>().addProductAddress(
        productId,
        onSuccess: (address) {
          context.pop(address);
        },
      ),
    );
  }
}
