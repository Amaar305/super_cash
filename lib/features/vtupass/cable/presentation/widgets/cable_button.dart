import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/cable/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class CableButton extends StatelessWidget {
  const CableButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CableCubit cubit) => cubit.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.proceed,
      onPressed: () async {
        final result = await context.push<bool?>(AppRoutes.confirmationDialog);

        await Future.delayed(200.milliseconds);

        if (result != null && result && context.mounted) {
          // context.showConfirmationBottomSheet(
          //   title: 'Cable Subscription Successful!',
          //   okText: AppStrings.done,
          //   description:
          //       'Your DSTV cable subscription purchase was successful.',
          // );

          context.read<CableCubit>().onValidateCable(
            onVerified: (p0) {
              // context.showConfirmationBottomSheet(
              //   title: 'Cable Subscription Successful!',
              //   okText: AppStrings.done,
              //   description:
              //       'Your DSTV cable subscription purchase was successful.',
              // );

              context.showExtraBottomSheet(
                title: 'Cable Validation Successful!',
                icon: Assets.images.circleCheck.image(fit: BoxFit.cover),
                description: 'Confirm below details before processing.',
                children: [
                  BlocProvider.value(
                    value: context.read<CableCubit>(),
                    child: SuccessValidaionSheet(
                      p0: p0,
                      onPurchased: () {
                        context.pop();
                        context.read<CableCubit>().onPurchaseCable((p0) {
                          context.showConfirmationBottomSheet(
                            title: 'You have successfully subscribed Cable!',
                            okText: 'Done',
                            description: p0,
                          );
                        });
                      },
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

class SuccessValidaionSheet extends StatelessWidget {
  const SuccessValidaionSheet({super.key, required this.p0, this.onPurchased});
  final Map p0;
  final VoidCallback? onPurchased;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: AppSpacing.lg,
      children: [
        DetailTile(title: 'Customer', subtitle: p0['Customer_Name']),
        DetailTile(title: "Card Number", subtitle: p0['Customer_Number']),
        DetailTile(title: 'Charges', subtitle: 'N50'),
        PrimaryButton(label: AppStrings.buy, onPressed: onPurchased),
      ],
    );
  }
}

class DetailTile extends StatelessWidget {
  const DetailTile({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final style = MonaSansTextStyle.label(
      fontWeight: AppFontWeight.black,
      fontSize: AppSpacing.md + 2,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: style),
        Text(subtitle, style: style),
      ],
    );
  }
}
