import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/app/routes/routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/card/virtual_card/virtual_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class NoCreditCardWidget extends StatelessWidget {
  const NoCreditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.emptyCard.image(),
          Gap.v(AppSpacing.xxlg),
          VirtualCardCreateButton(
            label: AppStrings.createVirtualCard,
            onTap: () => _handleVirtualCardCreation(context, user),
          ),
        ],
      ),
    );
  }

  void _handleVirtualCardCreation(BuildContext context, AppUser? user) {
    if (user == null) {
      context.read<AppBloc>().add(UserLoggedOut());
      return;
    }
    if (user.isSuspended) {
      _showSuspensionDialog(context);
    } else if (user.isKycVerified) {
      context.push(AppRoutes.virtualCardCreate);
    } else {
      _showUpgradeSheet(context);
    }
  }

  void _showUpgradeSheet(BuildContext context) {
    context.showExtraBottomSheet(
      title: AppStrings.upgradeYourAccount,
      description: AppStrings.upgradeAccountInstrucions,
      icon: Assets.images.upgradeUser.image(),
      children: [
        PrimaryButton(
          label: AppStrings.upgradeTierTwo,
          onPressed: () {
            context.pop();
            context.push(AppRoutes.upgradeTier);
          },
        ),
        SizedBox(
          width: double.infinity,
          child: AppOutlinedButton(
            isLoading: false,
            label: AppStrings.cancel,
            onPressed: context.pop,
          ),
        ),
      ],
    );
  }

  void _showSuspensionDialog(BuildContext context) {
    context.showAdaptiveDialog(
      barrierDismissible: false, // Make this stricter for security
      builder: (_) => _SuspensionDialog(),
    );
  }
}

class _SuspensionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: AlertDialog.adaptive(
        title: const Text(
          'Account Suspended',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Your account has been suspended due to a violation of our policies.\n\n'
          'You can no longer access this account. For more information, please contact support.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<AppBloc>().add(UserLoggedOut());
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
