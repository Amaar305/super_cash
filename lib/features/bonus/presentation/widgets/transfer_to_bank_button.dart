import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/bonus/bonus.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';

class TransferToBankButton extends StatelessWidget {
  const TransferToBankButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusCubit, BonusState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final isLoading = state.status.isLoading;
        final isValidated = state.status.isValidated;

        return PrimaryButton(
          isLoading: isLoading,
          label: !isValidated ? AppStrings.validate : AppStrings.send,
          onPressed: () async {
            if (!isValidated) {
              context.read<BonusCubit>().validateBank((result) {
                // _showValidationBottomSheet(context, result);
              });
            } else {
              final result = await context.push<bool?>(
                AppRoutes.confirmationDialog,
                extra: PurchaseDetail(
                  amount: state.amount.value,
                  title: 'Purchase Data',
                  description:
                      'You are Transfering bonus to ${state.selectedBank?.bankName} ${state.accountNumber.value} ',
                  purchaseType: PurchaseType.others,
                ),
              );

              if (result != null && result && context.mounted) {
                context.read<BonusCubit>().sendMoney();
              }
            }
          },
        );
      },
    );
  }

  // ignore: unused_element
  void _showValidationBottomSheet(BuildContext context, ValidatedBank result) {
    final bankName =
        context.read<BonusCubit>().state.selectedBank?.bankName ??
        result.bankCode;

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (sheetContext) {
        return _ValidatedBankBottomSheet(
          result: result,
          bankName: bankName,
          onSend: () {
            Navigator.of(sheetContext).pop();
            context.read<BonusCubit>().sendMoney();
          },
        );
      },
    );
  }
}

class _ValidatedBankBottomSheet extends StatelessWidget {
  const _ValidatedBankBottomSheet({
    required this.result,
    required this.bankName,
    required this.onSend,
  });

  final ValidatedBank result;
  final String bankName;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.45,
      child: AppConstrainedScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            spacing: AppSpacing.sm,
            children: [
              Assets.images.circleCheck.image(width: 55),
              Text('Account validated', style: context.titleMedium),
              Text(
                'Confirm the beneficiary details before sending your bonus.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: AppFontWeight.extraLight,
                  color: AppColors.emphasizeGrey,
                ),
              ),
              ValidationSummaryCard(
                bankName: bankName,
                accountName: result.accountName,
                accountNumber: result.accountNumber,
              ),
              PrimaryButton(label: AppStrings.send, onPressed: onSend),
              const Gap.v(AppSpacing.spaceUnit),
            ],
          ),
        ),
      ),
    );
  }
}
