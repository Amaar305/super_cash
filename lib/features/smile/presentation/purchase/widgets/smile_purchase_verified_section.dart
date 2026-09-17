import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/widgets.dart';
import 'package:super_cash/features/smile/domain/domain.dart';
import 'package:super_cash/features/smile/presentation/purchase/purchase.dart';

/// Shows the verified Smile customer's name and lets them pick which linked
/// account (`AccountId`) to fund, once their email has been verified.
class SmilePurchaseVerifiedSection extends StatelessWidget {
  const SmilePurchaseVerifiedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isVerified = context.select(
      (SmilePurchaseCubit c) => c.state.isVerified,
    );
    final customerName = context.select(
      (SmilePurchaseCubit c) => c.state.customerName,
    );
    final accounts = context.select((SmilePurchaseCubit c) => c.state.accounts);
    final selectedAccount = context.select(
      (SmilePurchaseCubit c) => c.state.selectedAccount,
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: !isVerified
          ? const SizedBox.shrink()
          : ValidationSummaryContainer(
              key: const ValueKey('smile-purchase-verified-section'),
              child: Column(
                spacing: AppSpacing.md,
                children: [
                  if (customerName != null && customerName.isNotEmpty)
                    ValidationDetailRow(
                      title: 'Customer',
                      value: customerName,
                      color: AppColors.green,
                    ),
                  if (accounts.length > 1) ...[
                    const AppDivider(),
                    Text(
                      AppStrings.smileAccount,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Column(
                      spacing: AppSpacing.sm,
                      children: accounts
                          .map(
                            (account) => _AccountTile(
                              account: account,
                              isSelected: account == selectedAccount,
                            ),
                          )
                          .toList(),
                    ),
                  ] else if (accounts.length == 1)
                    ValidationDetailRow(
                      title: AppStrings.smileAccount,
                      value: accounts.first.friendlyName.isEmpty
                          ? accounts.first.accountId
                          : accounts.first.friendlyName,
                    ),
                ],
              ),
            ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile({required this.account, required this.isSelected});

  final SmileAccount account;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: () =>
          context.read<SmilePurchaseCubit>().onAccountSelected(account),
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.blue : AppColors.brightGrey,
            width: isSelected ? 1.4 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.friendlyName.isEmpty
                        ? account.accountId
                        : account.friendlyName,
                    style: const TextStyle(fontWeight: AppFontWeight.semiBold),
                  ),
                  if (account.friendlyName.isNotEmpty)
                    Text(
                      account.accountId,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.emphasizeGrey,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.blue : AppColors.grey,
              size: AppSpacing.lg,
            ),
          ],
        ),
      ),
    );
  }
}
