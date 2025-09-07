import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation.dart';

class CardAppleProductSwitchSection extends StatelessWidget {
  const CardAppleProductSwitchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CardDetailCubit cubit) => cubit.state.status.isLoading,
    );

    final isAppleProduct = context.select(
      (CardDetailCubit cubit) => cubit.state.appleProduct,
    );

    void onSwitched() {
      context.showExtraBottomSheet(
        title: AppStrings.appleProduct,
        description: !isAppleProduct
            ? AppStrings.appleProductDescription
            : AppStrings.appleProductRevertDescription,
        icon: Assets.images.info.image(),
        children: [
          BlocProvider.value(
            value: context.read<CardDetailCubit>(),
            child: CardAppProductBottomSheetButton(),
          ),
          Row(
            children: [
              Expanded(
                child: AppOutlinedButton(
                  isLoading: false,
                  label: AppStrings.cancel,
                  onPressed: context.pop,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return CardBorderedContainer(
      height: null,
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppStrings.iwantPayForAppleProduct,
              style: TextStyle(fontSize: AppSpacing.md),
            ),
          ),
          Switch.adaptive(
            value: isAppleProduct,
            onChanged: isLoading ? null : (_) => onSwitched(),
            // ignore: deprecated_member_use
            activeColor: AppColors.blue,
          ),
        ],
      ),
    );
  }
}

class CardAppProductBottomSheetButton extends StatelessWidget {
  const CardAppProductBottomSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CardDetailCubit cubit) => cubit.state.status.isLoading,
    );

    final isAppleProduct = context.select(
      (CardDetailCubit cubit) => cubit.state.appleProduct,
    );

    return PrimaryButton(
      label: AppStrings.yesChangeBillingAddress,
      isLoading: isLoading,
      onPressed: () {
        context.read<CardDetailCubit>().onAppleProductSwitched(
          !isAppleProduct,
          onFinished: () {
            context.showConfirmationBottomSheet(
              title: AppStrings.appleProduct,
              okText: AppStrings.done,
              description: AppStrings.appleProductBillingDescription,
              onDone: () {
                context.pop();
                context.pop();
              },
            );
          },
        );
      },
    );
  }
}
