import 'package:app_ui/app_ui.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';

class CardTransactionCalculatorPage extends StatelessWidget {
  const CardTransactionCalculatorPage({super.key});

  static route() =>
      MaterialPageRoute(builder: (context) => CardTransactionCalculatorPage());

  @override
  Widget build(BuildContext context) {
    return const CardTransactionCalculatorView();
  }
}

class CardTransactionCalculatorView extends StatelessWidget {
  const CardTransactionCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.transactionCalculator),
        leading: AppLeadingAppBarWidget(onTap: () => Navigator.pop(context)),
      ),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              CardTransactionCalculatorForm(),
              Gap.v(AppSpacing.xlg),
              PurchaseContainerInfo(
                child: Text.rich(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppSpacing.md,
                    color: AppColors.blue,
                  ),
                  TextSpan(
                    text: 'This is the amount to fund your ',
                    children: [
                      TextSpan(
                        text: 'Available Balance ',
                        style: TextStyle(fontWeight: AppFontWeight.bold),
                      ),
                      TextSpan(text: 'with to cover the charges of 1%'),
                    ],
                  ),
                ),
              ),
              Gap.v(AppSpacing.xxlg),
              PrimaryButton(label: AppStrings.done, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class CardTransactionCalculatorForm extends StatelessWidget {
  const CardTransactionCalculatorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xxlg,
      children: [AmountForPaymentField(), AmountToFundField()],
    );
  }
}

class AmountForPaymentField extends StatelessWidget {
  const AmountForPaymentField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          'Enter Amount for your payment(\$):',
          style: TextStyle(
            fontWeight: AppFontWeight.medium,
            fontSize: AppSpacing.md,
          ),
        ),
        AppTextField(
          hintText: '2.00',
          filled: Config.filled,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}

class AmountToFundField extends StatelessWidget {
  const AmountToFundField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          'Amount to fund your Available Balance with(\$):',
          style: TextStyle(
            fontWeight: AppFontWeight.medium,
            fontSize: AppSpacing.md,
          ),
        ),
        AppTextField(
          hintText: '1.00',
          filled: Config.filled,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
