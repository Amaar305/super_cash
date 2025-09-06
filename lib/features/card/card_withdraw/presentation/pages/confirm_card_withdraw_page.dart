// ignore_for_file: deprecated_member_use

import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../card.dart';

class ConfirmCardWithdrawPage extends StatelessWidget {
  const ConfirmCardWithdrawPage({
    super.key,
    required this.cardId,
    required this.cubit,
  });
  final String cardId;
  final CardWithdrawCubit cubit;

  static route({required String cardId, required CardWithdrawCubit cubit}) =>
      MaterialPageRoute(
        builder: (context) =>
            ConfirmCardWithdrawPage(cardId: cardId, cubit: cubit),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: ConfirmCardWithdrawView(cardId: cardId),
    );
  }
}

class ConfirmCardWithdrawView extends StatelessWidget {
  const ConfirmCardWithdrawView({super.key, required this.cardId});
  final String cardId;

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: VeryPurchaseWidget(),
                ),
                CardDetailContainer(
                  text: 'Total Amount to Pay: ',
                  text2: '\$31 - N4,590',
                ),
                AppPinForm(
                  onCompleted: (p0) {
                    context.showConfirmationBottomSheet(
                      title: 'Card Withdraw Initiated',
                      description: 'Card Withdraw in progress....',
                      okText: AppStrings.done,
                    );
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
