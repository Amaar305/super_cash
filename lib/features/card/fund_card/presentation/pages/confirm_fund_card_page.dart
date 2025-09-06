// ignore_for_file: deprecated_member_use

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../card.dart';

class ConfirmFundCardPage extends StatelessWidget {
  const ConfirmFundCardPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => ConfirmFundCardPage(),
      );

  @override
  Widget build(BuildContext context) {
    return const ConfirmFundCardView();
  }
}

class ConfirmFundCardView extends StatelessWidget {
  const ConfirmFundCardView({super.key});
  void _confirmAlertDialog(BuildContext context) => context.confirmAction(
        fn: () => Navigator.pop(context),
        title: AppStrings.goBackTitle,
        content: AppStrings.goBackDescrption,
        noText: AppStrings.cancel,
        yesText: AppStrings.goBack,
        yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
      );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _confirmAlertDialog(context);

        return await Future.value(false);
      },
      child: AppScaffold(
        appBar: AppBar(
          leading: AppLeadingAppBarWidget(
            onTap: () => _confirmAlertDialog(context),
          ),
          title: AppAppBarTitle(AppStrings.cardPaymentValidation),
        ),
        body: AppConstrainedScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              spacing: AppSpacing.xlg,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: VeryPurchaseWidget(),
                ),
                CardDetailContainer(
                  text: 'Total Amount to Pay: ',
                  text2: '\$31 - N4,590',
                ),
                AppPinForm(
                  onCompleted: (p0) {
                    context.showConfirmationBottomSheet(
                      title: 'Card Funding Initiated',
                      description: 'Card Funding in progress....',
                      okText: 'Done',
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
