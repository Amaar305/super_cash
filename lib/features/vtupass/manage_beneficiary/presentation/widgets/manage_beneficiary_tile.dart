import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/entities.dart';
import '../presentation.dart';

class ManageBeneficiaryTile extends StatelessWidget {
  const ManageBeneficiaryTile({super.key, required this.beneficiary});

  final Beneficiary beneficiary;

  @override
  Widget build(BuildContext context) {
    void onBeneficiaryDelete() => context.showExtraBottomSheet(
      title: AppStrings.warning,
      description: AppStrings.deleteBeneficiaryInfo,
      icon: Assets.images.warning.image(),
      children: [
        PrimaryButton(
          label: AppStrings.yesContinue,
          onPressed: () {
            context.pop();
            context.read<ManageBeneficiaryCubit>().deleteBeneficiary(
              beneficiary.id,
            );
          },
        ),
        Row(
          children: [
            Expanded(
              child: AppOutlinedButton(
                isLoading: false,
                label: AppStrings.cancel,
                onPressed: context.pop,
              ),
            ),
          ],
        ),
      ],
    );
    return Column(
      children: [
        Row(
          children: [
            SizedBox.square(
              dimension: 32,
              child: Assets.icons.beneficiaryIcon.svg(),
            ),
            Gap.h(AppSpacing.xs),
            _buildNameAndNumber(
              context,
              name: beneficiary.name,
              number: beneficiary.phone,
            ),
            Spacer(),
            ManageBeneficiaryIconActionButton(
              label: AppStrings.edit,
              icon: Assets.icons.editBeneficiary.svg(),
              onTap: () => onEditted(context),
            ),
            Gap.h(AppSpacing.sm),
            ManageBeneficiaryIconActionButton(
              label: AppStrings.delete,
              icon: Assets.icons.deleteBeneficiay.svg(),
              onTap: onBeneficiaryDelete,
            ),
          ],
        ),
        Divider(thickness: 0.3),
      ],
    );
  }

  Column _buildNameAndNumber(
    BuildContext context, {
    required String name,
    required String number,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.xxs,
      children: [
        Text(name, style: Theme.of(context).textTheme.labelLarge),
        Text(number, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Future<void> onEditted(BuildContext context) async {
    final result = await context.push<bool?>(
      AppRoutes.saveBeneficiary,
      extra: beneficiary,
    );
    if (result == true && context.mounted) {
      context.read<ManageBeneficiaryCubit>().fetchBeneficiaries(
        forceReload: true,
      );
    }
  }
}
