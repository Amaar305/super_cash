import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class ElectricityButton extends StatelessWidget {
  const ElectricityButton({super.key});

  @override
  Widget build(BuildContext context) {
    void verify(Map val) {
      context.showExtraBottomSheet(
        title: 'Electricity Validation Successful!',
        description: val['message'],
        icon: Assets.images.circleCheck.image(),
        children: [
          Text(
            'Token Number',
            style: TextStyle(
              fontSize: AppSpacing.lg + 1,
              fontWeight: AppFontWeight.bold,
              color: AppColors.deepBlue,
            ),
          ),
          Row(
            spacing: AppSpacing.sm,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '0000-0000- 00000-000000',
                style: TextStyle(
                  fontWeight: AppFontWeight.medium,
                  fontSize: AppSpacing.lg,
                ),
              ),
              Tappable.scaled(
                onTap: () {},
                child: Icon(Icons.copy_outlined, size: AppSpacing.lg),
              ),
            ],
          ),
          Gap.v(AppSpacing.md),
          PrimaryButton(
            label: AppStrings.buy,
            onPressed: () {
              context.read<ElectricityCubit>().onElectrityPurchase(
                onPurchased: (transaction) {
                  context.showConfirmationBottomSheet(
                    title: 'Your power purchase was successful.',
                    okText: 'Done',
                    description: transaction.description,
                  );
                },
              );
            },
          ),
        ],
      );
    }

    return PrimaryButton(
      label: AppStrings.proceed,
      onPressed: () async {
        final result = await context.push<bool?>(AppRoutes.confirmationDialog);

        await Future.delayed(200.milliseconds);

        if (result != null && result && context.mounted) {
          context.read<ElectricityCubit>().onElectricityValidation(
            onVerified: verify,
          );
        }
      },
    );
  }
}
