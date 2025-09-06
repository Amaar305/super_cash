// ignore_for_file: deprecated_member_use

import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_strings/app_string.dart';

class AirtmeConfirmPage extends StatelessWidget {
  const AirtmeConfirmPage({super.key});
  final String otp = '5555';

  @override
  Widget build(BuildContext context) {
    void confirmGoBack(BuildContext context) => context.confirmAction(
      fn: () => context.pop(),
      title: AppStrings.goBackTitle,
      content: AppStrings.goBackDescrption,
      noText: AppStrings.cancel,
      yesText: AppStrings.goBack,
      yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
    );
    return WillPopScope(
      onWillPop: () {
        confirmGoBack(context);
        return Future.value(false);
      },
      child: AppScaffold(
        appBar: AppBar(
          leading: AppLeadingAppBarWidget(onTap: () => confirmGoBack(context)),
          title: AppAppBarTitle(AppStrings.enterPin),
        ),
        releaseFocus: true,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              spacing: AppSpacing.spaceUnit,
              children: [
                VeryPurchaseWidget(),
                VeryPurchaseInfo(amount: '1000', number: '0900112233'),
                AppPinForm(
                  obscured: true,
                  onCompleted: (pin) {
                    if (pin == otp) {
                      context.showBeneficiaryConfirmationBottomSheet(
                        title: 'Airtime Purchase Successful!',
                        okText: 'Done',
                        description: 'Your airtime purchase was successful.',
                        cancelText: 'Cancel',
                        onSaved: () {},
                      );
                    } else {
                      openSnackbar(
                        SnackbarMessage.error(title: 'Incorrect pin.'),
                        clearIfQueue: true,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VeryPurchaseInfo extends StatelessWidget {
  const VeryPurchaseInfo({
    super.key,
    required this.amount,
    required this.number,
    this.text1 = 'You are sending ',
    this.text2 = 'airtime to ',
  });

  final String amount;
  final String number;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return PurchaseContainerInfo(
      child: Column(
        spacing: AppSpacing.sm,
        children: [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: text1,
              children: [
                TextSpan(
                  text: '$amount ',
                  style: TextStyle(
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.blue,
                  ),
                ),
                TextSpan(text: text2),
                TextSpan(
                  text: number,
                  style: TextStyle(
                    fontWeight: AppFontWeight.semiBold,
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
            style: TextStyle(fontSize: 12),
          ),
          Text(
            'Enter your transaction pin to proceed',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
