import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewWallet extends StatelessWidget {
  const NewWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16).copyWith(top: 24),
      margin: EdgeInsets.all(24).copyWith(top: 16),
      // height: 200,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        // spacing: AppSpacing.sm,
        children: [
          Text(
            'Wallet Balance',
            style: poppinsTextStyle(
              color: AppColors.white,
              fontSize: 13,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          Gap.v(AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tappable.faded(
                onTap: () =>
                    context.read<HomeCubit>().onRefresh(forceRefresh: true),
                child: Icon(Icons.refresh, color: AppColors.white),
              ),
              Balance(),
              HomeShowBalanceIcon(),
            ],
          ),
          Gap.v(AppSpacing.sm),
          Bonus(),
          Gap.v(AppSpacing.sm),
          Divider(),
          Gap.v(AppSpacing.sm),
          Text(
            AppStrings.accountNumber,
            style: poppinsTextStyle(
              color: AppColors.white,
              fontWeight: AppFontWeight.semiBold,
              fontSize: 11,
            ),
          ),
          Gap.v(AppSpacing.sm),
          WalletAccounts(),
        ],
      ),
    );
  }
}

class WalletAccounts extends StatelessWidget {
  const WalletAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = context.select(
      (HomeCubit element) => element.state.user.accounts.take(2).toList(),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: accounts
          .map(
            (account) => HomeAccountDetailWidget(
              accountNumber: account.accountNumber,
              accountName: account.bankName,
            ),
          )
          .toList(),
    );
  }
}
