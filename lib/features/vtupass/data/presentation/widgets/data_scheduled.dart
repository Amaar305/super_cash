import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/auth/widgets/auth_social_container.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataScheduled extends StatelessWidget {
  const DataScheduled({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap.v(AppSpacing.xxxlg * 2),

          AuthContainer(
            child: Column(
              children: [
                Icon(
                  Icons.info_outline,
                  size: AppSpacing.xxxlg / 1.2,
                  color: AppColors.primary2,
                ),
                Gap.v(AppSpacing.lg),
                Text(
                  'Oops!',
                  style: context.bodyMedium?.copyWith(fontSize: AppSpacing.xlg),
                ),
                Gap.v(AppSpacing.md),
                Text(
                  'Coming soon.',
                  textAlign: TextAlign.center,
                  style: context.bodyMedium?.copyWith(
                    fontSize: AppSpacing.lg,
                    fontFamily: 'MonaSans',
                    fontWeight: AppFontWeight.black,
                    height: 1.6,
                  ),
                ),
                Gap.v(AppSpacing.xlg),
                PrimaryButton(
                  label: 'Use Instant Data',
                  onPressed: () =>
                      context.read<DataCubit>().onToggleShowPassword(true),
                ),
              ],
            ),
          ),
          // Gap.v(AppSpacing.xxlg * 8),
        ],
      ),
    );
  }
}
