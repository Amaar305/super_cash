import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/cable/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CableButton extends StatelessWidget {
  const CableButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CableCubit cubit) => cubit.state.status.isLoading,
    );
    final isValidated = context.select(
      (CableCubit cubit) => cubit.state.status.isValidated,
    );
    final plan = context.select((CableCubit cubit) => cubit.state.plan);
    final phone = context.select((CableCubit cubit) => cubit.state.phone);
    final decoder = context.select(
      (CableCubit cubit) => cubit.state.cardNumber,
    );
    final hasProvider = context.select(
      (CableCubit cubit) => cubit.state.selectedProvider != null,
    );
    final isEnabled =
        !isLoading &&
        hasProvider &&
        plan != null &&
        phone.valid &&
        decoder.valid &&
        phone.value.trim().isNotEmpty &&
        decoder.value.trim().isNotEmpty;

    return PrimaryButton(
      isLoading: isLoading,
      label: isValidated ? AppStrings.buy : AppStrings.proceed,
      onPressed: !isEnabled
          ? null
          : () => _handlePressed(context: context, isValidated: isValidated),
    );
  }

  Future<void> _handlePressed({
    required BuildContext context,
    required bool isValidated,
  }) async {
    final cubit = context.read<CableCubit>()
      ..onDecoderFocused()
      ..onPhoneFocused();

    if (isValidated) {
      final result = await context.push<bool?>(AppRoutes.confirmationDialog);

      if (result == true && context.mounted) {
        cubit.onPurchaseCable((description) {
          context.showConfirmationBottomSheet(
            title: 'You have successfully subscribed Cable!',
            okText: 'Done',
            description: description,
          );
        });
      }
      return;
    }

    cubit.onValidateCable(
      onVerified: (payload) => _showValidationSheet(context, payload),
    );
  }
}

void _showValidationSheet(BuildContext context, Map<String, dynamic> payload) {
  if (!context.mounted) return;

  context.showExtraBottomSheet(
    title: 'Cable Validation Successful!',
    icon: Assets.images.circleCheck.image(fit: BoxFit.cover),
    description: 'Confirm below details before processing.',
    children: [
      BlocProvider.value(
        value: context.read<CableCubit>(),
        child: SuccessValidationSheet(
          payload: payload,
          onPurchased: () async {
            context.pop();

            final result = await context.push<bool?>(
              AppRoutes.confirmationDialog,
            );

            if (result == true && context.mounted) {
              context.read<CableCubit>().onPurchaseCable((description) {
                context.showConfirmationBottomSheet(
                  title: 'You have successfully subscribed Cable!',
                  okText: 'Done',
                  description: description,
                );
              });
            }
          },
        ),
      ),
    ],
  );
}

class SuccessValidationSheet extends StatelessWidget {
  const SuccessValidationSheet({
    super.key,
    required this.payload,
    this.onPurchased,
  });
  final Map<String, dynamic> payload;
  final VoidCallback? onPurchased;

  @override
  Widget build(BuildContext context) {
    final customerName = '${payload['Customer_Name'] ?? ''}'.trim();
    final cardNumber = '${payload['Customer_Number'] ?? ''}'.trim();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: AppSpacing.lg,
      children: [
        PurchaseContainerInfo(
          child: Column(
            spacing: AppSpacing.sm,
            children: [
              DetailTile(
                title: 'Customer',
                subtitle: customerName.isEmpty ? 'N/A' : customerName,
              ),
              DetailTile(
                title: 'Card Number',
                subtitle: cardNumber.isEmpty ? 'N/A' : cardNumber,
              ),
              const DetailTile(title: 'Charges', subtitle: 'N50'),
            ],
          ),
        ),
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
