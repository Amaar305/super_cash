import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

class SmileProceedButton extends StatelessWidget {
  const SmileProceedButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SmileCubit cubit) => cubit.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.buy,
      onPressed: () async {
        final result = await context.push<bool?>(AppRoutes.confirmationDialog);

        await Future.delayed(200.milliseconds);

        if (result != null && result && context.mounted) {
          context.showConfirmationBottomSheet(
            title: AppStrings.purchaseSuccessfull,
            okText: AppStrings.done,
            description: 'Your smile voice has been purchased successfully.',
          );
        }
      },
    );
  }
}
