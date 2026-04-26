import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ProductGiveawayPage extends StatelessWidget {
  const ProductGiveawayPage({super.key, required this.giveawayTypeId});
  final String giveawayTypeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductGiveawayCubit(
        getProductsGiveawayUseCase:
            serviceLocator<GetProductsGiveawayUseCase>(),
        addProductDeliveryAddressUseCase:
            serviceLocator<AddProductDeliveryAddressUseCase>(),
        claimProductGiveawayUseCase:
            serviceLocator<ClaimProductGiveawayUseCase>(),
        giveawayTypeId: giveawayTypeId,
        user: context.read<AppCubit>().state.user!,
      )..getProducts(),
      child: PoductGiveawayView(),
    );
  }
}

class PoductGiveawayView extends StatelessWidget {
  const PoductGiveawayView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Product Giveaway')),
      body: BlocListener<ProductGiveawayCubit, ProductGiveawayState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isLoading) {
            showLoadingOverlay(context);
          } else {
            hideLoadingOverlay();
          }

          if (state.status.isFailed && state.message.isNotEmpty) {
            openSnackbar(
              SnackbarMessage.error(title: state.message),
              clearIfQueue: true,
            );
          }
        },
        child: _ProductListView(),
      ),
    );
  }
}

class _ProductListView extends StatelessWidget {
  const _ProductListView();

  @override
  Widget build(BuildContext context) {
    final products = context.select(
      (ProductGiveawayCubit cubit) => cubit.state.products,
    );
    if (products.isEmpty) {
      return AppEmptyState(
        title: 'No available products',
        icon: Icons.production_quantity_limits_outlined,
        action: TextButton.icon(
          onPressed: context.read<ProductGiveawayCubit>().getProducts,
          label: Text('Refresh'),
          icon: Icon(Icons.refresh),
        ),
      );
    }
    return ListView.builder(
      itemCount: products.length,
      padding: EdgeInsets.all(AppSpacing.lg),
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductGiveawayCard(
          product: product,
          onSuccessfulClaimed: (value) async {
            final cubit = context.read<ProductGiveawayCubit>();
            //  Show bottom sheet to successful claimed message and a fields to collect full name, phone number, state, and home address.

            final succes =
                await showModalBottomSheet<ProductClaimAddressModel?>(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  enableDrag: false,
                  showDragHandle: false,
                  builder: (context) {
                    return BlocProvider.value(
                      value: cubit,
                      child: AddProductAddressPage(product: product),
                    );
                  },
                );

            if (succes != null && context.mounted) {
              context.showConfirmationBottomSheet(
                title: 'Your product will be shipped shortly.',
                okText: 'Done',
                description:
                    "Your product's delivery status is ${succes.deliveryStatus}. Will arrive within 2 working days.",
              );
            }
          },
        );
      },
    );
  }
}
