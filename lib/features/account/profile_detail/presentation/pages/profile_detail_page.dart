import 'package:app_ui/app_ui.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../account.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileDetailView();
  }
}

class ProfileDetailView extends StatelessWidget {
  const ProfileDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.profileDetails),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              UserProfileDetails(),
              Gap.v(AppSpacing.xxlg),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSpacing.xlg),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.xs),
                  border: Border.all(
                    width: 1.2,
                    color: Color.fromRGBO(246, 248, 250, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(246, 248, 250, 1),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                alignment: Alignment(0, 0),
                child: const Details(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select(
      (AppCubit cubit) => cubit.state.user ?? AppUser.anonymous,
    );

    return Column(
      children: [
        ProfileDetailTile(
          label: AppStrings.firstName,
          trailingLabel: user.firstName,
        ),
        ProfileDetailTile(
          label: AppStrings.lastName,
          trailingLabel: user.lastName,
        ),
        ProfileDetailTile(
          label: AppStrings.emailAddress,
          trailingLabel: user.email,
        ),
        ProfileDetailTile(
          label: AppStrings.phoneNumber,
          trailingLabel: user.phone,
        ),
        // ProfileDetailTile(
        //   label: AppStrings.joinedDate,
        //   trailingLabel: '12th March, 2025',
        // ),
        // ProfileDetailTile(
        //   label: AppStrings.referralCode,
        //   trailingLabel: '${user.email.split('@')[0]}123',
        // ),
        ProfileDetailTile(
          label: AppStrings.kycStatus,
          trailingLabel: user.isKycVerified ? 'KYC Completed' : 'KYC Pending',
          trailingLabelColor: user.isKycVerified
              ? AppColors.green
              : AppColors.red,
        ),
        ProfileDetailTile(
          label: AppStrings.accountStatus,
          trailingLabel: user.isSuspended ? 'Suspended' : 'Active',
          trailingLabelColor: user.isSuspended
              ? AppColors.red
              : AppColors.green,
        ),
        ProfileDetailTile(
          label: AppStrings.accountTier,
          trailingLabel: user.userTier.capitalize,
        ),
      ],
    );
  }
}
