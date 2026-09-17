import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/smile/presentation/purchase/purchase.dart';

class SmilePurchaseForm extends StatefulWidget {
  const SmilePurchaseForm({super.key});

  @override
  State<SmilePurchaseForm> createState() => _SmilePurchaseFormState();
}

class _SmilePurchaseFormState extends State<SmilePurchaseForm> {
  @override
  void dispose() {
    hideLoadingOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SmilePurchaseCubit, SmilePurchaseState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isLoading) {
          showLoadingOverlay(context);
        } else {
          hideLoadingOverlay();
        }

        if (state.status.isError) {
          final account = state.selectedAccount;
          final summary = PurchaseContainerInfo(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xs,
              children: [
                Text(
                  'Review selection',
                  style: poppinsTextStyle(fontWeight: AppFontWeight.semiBold),
                ),
                _SummaryRow(label: 'Plan', value: state.plan.name),
                if (account != null)
                  _SummaryRow(
                    label: 'Account',
                    value: account.friendlyName.isEmpty
                        ? account.accountId
                        : account.friendlyName,
                  ),
                _SummaryRow(
                  label: 'Phone',
                  value: state.phone.value.isEmpty
                      ? 'Not set'
                      : state.phone.value,
                ),
              ],
            ),
          );

          context.showFailureBottomSheet<void>(
            message: state.message.isEmpty ? null : state.message,
            details: summary,
            onPrimary: () {
              if (!context.mounted) return;
              if (!state.isVerified) {
                context.read<SmilePurchaseCubit>().verifyEmail();
              }
            },
            onSecondary: () {
              if (context.mounted) context.pop();
            },
          );
        }
      },
      child: const Column(
        spacing: AppSpacing.xlg,
        children: [
          SmilePurchasePlanPreview(),
          SmilePurchaseEmailField(),
          SmilePurchaseVerifiedSection(),
          SmilePurchasePhoneField(),
          SmilePurchaseActionButtons(),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

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
