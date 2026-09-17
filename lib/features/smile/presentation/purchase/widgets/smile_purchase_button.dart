import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';
import 'package:super_cash/features/smile/domain/domain.dart';
import 'package:super_cash/features/smile/presentation/purchase/purchase.dart';

class SmilePurchaseButton extends StatelessWidget {
  const SmilePurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SmilePurchaseCubit c) => c.state.status.isLoading,
    );
    final isVerified = context.select(
      (SmilePurchaseCubit c) => c.state.isVerified,
    );
    final email = context.select((SmilePurchaseCubit c) => c.state.email);
    final phone = context.select((SmilePurchaseCubit c) => c.state.phone);

    final isEnabled = isVerified
        ? phone.value.trim().isNotEmpty
        : email.value.trim().isNotEmpty;

    return PrimaryButton(
      isLoading: isLoading,
      label: isVerified ? AppStrings.buy : AppStrings.verifyEmail,
      onPressed: !isEnabled
          ? null
          : () => isVerified ? _buy(context) : _verify(context),
    );
  }

  void _verify(BuildContext context) {
    final cubit = context.read<SmilePurchaseCubit>();
    final email = Email.dirty(cubit.state.email.value);

    if (!email.valid) {
      cubit.onEmailFocused();
      openSnackbar(
        SnackbarMessage.error(
          title: email.errorMessage ?? 'Please enter a valid Smile email.',
        ),
        clearIfQueue: true,
      );
      return;
    }

    cubit.verifyEmail();
  }

  Future<void> _buy(BuildContext context) async {
    final cubit = context.read<SmilePurchaseCubit>();
    cubit.onPhoneFocused();

    final state = cubit.state;
    final account = state.selectedAccount;

    if (account == null) {
      openSnackbar(
        SnackbarMessage.error(title: 'Please select which account to fund.'),
        clearIfQueue: true,
      );
      return;
    }
    if (!state.phone.valid) {
      openSnackbar(
        SnackbarMessage.error(
          title:
              state.phone.errorMessage ?? 'Please enter a valid phone number.',
        ),
        clearIfQueue: true,
      );
      return;
    }

    final plan = state.plan;
    final total = plan.total;
    final amount = total == total.roundToDouble()
        ? total.toStringAsFixed(0)
        : total.toStringAsFixed(2);
    final accountLabel = account.friendlyName.isEmpty
        ? account.accountId
        : account.friendlyName;

    final result = await context.push<bool?>(
      AppRoutes.confirmationDialog,
      extra: PurchaseDetail(
        amount: amount,
        title: 'Purchase Smile Data',
        description: 'You are purchasing ${plan.name} for $accountLabel',
        purchaseType: PurchaseType.data,
      ),
    );

    if (result == true && context.mounted) {
      context.read<SmilePurchaseCubit>().purchase(
        onSuccess: (transaction) {
          if (!context.mounted) return;
          _showSuccessSheet(context, transaction, plan, accountLabel);
        },
      );
    }
  }

  void _showSuccessSheet(
    BuildContext context,
    TransactionResponse transaction,
    SmilePlan plan,
    String accountLabel,
  ) {
    context.showExtraBottomSheet(
      title: 'Smile Data Purchase Successful!',
      description: transaction.description,
      icon: Assets.images.circleCheck.image(),
      children: [
        PurchaseContainerInfo(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.xs,
            children: [
              Text(
                'Purchase details',
                style: const TextStyle(fontWeight: AppFontWeight.semiBold),
              ),
              _DetailRow(label: 'Plan', value: plan.name),
              _DetailRow(label: 'Account', value: accountLabel),
              _DetailRow(label: 'Amount', value: transaction.formattedAmount),
            ],
          ),
        ),
        PrimaryButton(
          label: 'Done',
          onPressed: () => context
            ..pop()
            ..pop()
            ..pop(),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.emphasizeGrey, fontSize: 12),
        ),
        Flexible(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: AppFontWeight.semiBold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
