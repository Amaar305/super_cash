import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
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
      ),
      child: PoductGiveawayView(),
    );
  }
}

class PoductGiveawayView extends StatefulWidget {
  const PoductGiveawayView({super.key});

  @override
  State<PoductGiveawayView> createState() => _PoductGiveawayViewState();
}

class _PoductGiveawayViewState extends State<PoductGiveawayView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductGiveawayCubit>().getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Product Giveaway')),
      body: RefreshIndicator.adaptive(
        onRefresh: context.read<ProductGiveawayCubit>().getProducts,
        child: BlocListener<ProductGiveawayCubit, ProductGiveawayState>(
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
          child: Column(
            children: [
              ProductHeader(),
              Expanded(child: _ProductListView()),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductHeader extends StatelessWidget {
  const ProductHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final totalProduct = context.select<ProductGiveawayCubit, int>(
      (value) => value.state.totalProducts,
    );
    final totalAvailableProducts = context.select<ProductGiveawayCubit, int>(
      (value) => value.state.totalAvailableProducts,
    );
    final remainingPercent = context.select<ProductGiveawayCubit, double>(
      (value) => value.state.remainingPercent,
    );

    return Row(
      spacing: AppSpacing.lg,
      children: [
        Expanded(
          child: GiveawayAnalyticsHeaderItem(
            title: 'TOTAL PRODUCT',
            icon: Icons.production_quantity_limits,
            subtitle: totalProduct.planDisplayAmount,
            footerTitle: 'Across all active drops',
          ),
        ),
        Expanded(
          child: GiveawayAnalyticsHeaderItem(
            title: 'AVAILABLE TO CLAIM',
            icon: Icons.shopping_bag_outlined,
            subtitle: totalAvailableProducts.planDisplayAmount,
            footerTitle: '${remainingPercent.toStringAsFixed(1)}% REMAINING',
            footerTitleColor: Color(0xff006E2F),
            extraWidget: SizedBox(
              width: double.infinity,
              height: 4,
              child: LinearProgressIndicator(
                value: remainingPercent,
                color: Color(0xff006E2F),
                borderRadius: BorderRadius.circular(999),
                // minHeight: 4,
              ),
            ),
          ),
        ),
      ],
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
