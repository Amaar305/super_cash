import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/referral_type/presentation/presentation.dart';

class ReferralSelectionButton extends StatelessWidget {
  const ReferralSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ReferralTypeCubit element) => element.state.status.isLoading,
    );
    final isSelected = context.select(
      (ReferralTypeCubit element) =>
          element.state.selectedCampaign != null &&
          element.state.termsContidition,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.confirmation,
      onPressed: !isSelected
          ? null
          : () {
              final cubit = context.read<ReferralTypeCubit>();
              cubit.onEnroll((result) {
                if (!context.mounted) return;
                context.showConfirmationBottomSheet(
                  title: 'Enrollment successful',
                  okText: AppStrings.proceed,
                  description:
                      'Your referral enrollment is successful, you are required to invite the number of users selected before and gain their rewards when their account has been verified successfull and perform a data transaction. ',
                  onDone: () {
                    context.pop();
                    context.read<AppCubit>().userStarted(true);
                  },
                );
              });
            },
    );
  }
}

class ReferralEnrollmentSheet extends StatelessWidget {
  const ReferralEnrollmentSheet({
    super.key,
    required this.campaignId,
    required this.referralCode,
  });

  final String campaignId;
  final String referralCode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xlg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.lg,
          children: [
            Text(
              'Enrollment successful',
              style: context.titleMedium,
              textAlign: TextAlign.center,
            ),
            _ReferralInfoTile(
              label: AppStrings.referralCode,
              value: referralCode,
              onTap: () {
                Clipboard.setData(ClipboardData(text: referralCode));
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Referral code copied to clipboard'),
                    ),
                  );
              },
            ),
            _ReferralInfoTile(
              label: 'Campaign ID',
              value: campaignId.isNotEmpty ? campaignId : 'Unavailable',
            ),
            PrimaryButton(
              label: AppStrings.done,
              onPressed: () {
                // Navigator.of(context).pop();
                // context.read<AppCubit>().userStarted(true);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReferralInfoTile extends StatelessWidget {
  const _ReferralInfoTile({
    required this.label,
    required this.value,
    this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tile = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardContainerColor,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xs,
        children: [
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.emphasizeGrey,
            ),
          ),
          Row(
            spacing: AppSpacing.sm,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.deepBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onTap != null)
                Icon(Icons.copy_outlined, color: AppColors.deepBlue),
            ],
          ),
        ],
      ),
    );

    if (onTap == null) {
      return tile;
    }

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        onTap: onTap,
        child: tile,
      ),
    );
  }
}
