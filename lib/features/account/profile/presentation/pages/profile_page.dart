import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/routes/routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../home/presentation/cubit/home_cubit.dart';
import '../../../account.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return ProfileView(userId: userId);
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle(AppStrings.profile)),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserProfileDetails(),
              Gap.v(AppSpacing.xxlg),
              Text(AppStrings.accountSettings, style: poppinsTextStyle()),
              Gap.v(AppSpacing.sm),
              ProfileSettingsContainer(
                child: Column(
                  children: [
                    NewWidget(
                      label: AppStrings.profileDetails,
                      icon: Iconsax.user,
                      onTap: () => context.push(AppRoutes.profileDetails),
                    ),
                    NewWidget(
                      label: AppStrings.accountVerification,
                      icon: Iconsax.location,
                      onTap: () => context.push(AppRoutes.upgradeTier),
                    ),
                    NewWidget(
                      label: AppStrings.changePassword,
                      icon: Iconsax.arrow_swap,
                      onTap: () => context.push(AppRoutes.changePassword),
                    ),
                    NewWidget(
                      label: AppStrings.manageTransactionPin,
                      icon: Iconsax.password_check,
                      onTap: () => context.push(AppRoutes.manageTransactionPin),
                    ),
                  ],
                ),
              ),
              Gap.v(AppSpacing.xxlg),
              Text('Support & About', style: poppinsTextStyle()),
              Gap.v(AppSpacing.sm),
              ProfileSettingsContainer(
                child: Column(
                  children: [
                    NewWidget(
                      label: AppStrings.legalAndOthers,
                      icon: Iconsax.activity,
                    ),
                    NewWidget(
                      label: AppStrings.myReferrals,
                      icon: Iconsax.people,
                    ),
                    NewWidget(
                      label: AppStrings.deleteAccount,
                      icon: Iconsax.user_add,
                    ),
                  ],
                ),
              ),
              Gap.v(AppSpacing.xxlg),
              Center(
                child: AppButton(
                  text: AppStrings.logout,
                  onPressed: () {
                    context.showAdaptiveDialog(
                      title: 'Logout!',
                      content: 'Are you sure you want to logout?',
                      actions: [
                        TextButton(
                          onPressed: context.read<HomeCubit>().onLogout,
                          child: Text('Logout'),
                        ),
                        TextButton(
                          onPressed: context.pop,
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                  icon: Icon(Iconsax.logout, color: AppColors.white),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.primary2,
                    fixedSize: Size(150, 50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.label,
    this.onTap,
    required this.icon,
  });
  final String label;
  final VoidCallback? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: Icon(icon, size: AppSpacing.xlg - 4),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      title: Text(label, style: poppinsTextStyle(fontSize: AppSpacing.md)),
    );
  }
}

class ProfileSettingsContainer extends StatelessWidget {
  const ProfileSettingsContainer({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
