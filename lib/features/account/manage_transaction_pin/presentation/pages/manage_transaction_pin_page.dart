import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../account.dart';

class ManageTransactionPinPage extends StatelessWidget {
  const ManageTransactionPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ManageTransactionPinView();
  }
}

class ManageTransactionPinView extends StatelessWidget {
  const ManageTransactionPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.manageTransactionPin),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              ProfileTile(
                label: AppStrings.changeTransactionPin,
                subtile: AppStrings.changeTransactionPinSubtitle,
                leadingIcon: Assets.icons.buy.svg(),
                leadingColor: ProfileTileColors.color4,
                onTap: () =>
                    Navigator.push(context, ChangeTransactionPinPage.route()),
              ),
              ProfileTile(
                label: AppStrings.resetTransactionPin,
                subtile: AppStrings.resetTransactionPinSubtitle,
                leadingIcon: Assets.icons.buy.svg(),
                leadingColor: ProfileTileColors.color4,
                onTap: () =>
                    Navigator.push(context, ResetTransactionPinPage.route()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
