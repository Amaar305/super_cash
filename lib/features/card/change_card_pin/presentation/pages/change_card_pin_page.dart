import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../../card.dart';

class ChangeCardPinPage extends StatelessWidget {
  const ChangeCardPinPage({super.key, required this.cardId, this.card});

  final String cardId;
  final CardDetails? card;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeCardPinCubit(
        cardId: cardId,
        changeCardPinUseCase: serviceLocator(),
      ),
      child: ChangeCardPinView(cardId: cardId, cardDetails: card),
    );
  }
}

class ChangeCardPinView extends StatelessWidget {
  const ChangeCardPinView({super.key, required this.cardId, this.cardDetails});
  final String cardId;
  final CardDetails? cardDetails;

  void _confirmGoBack(BuildContext context) => context.confirmAction(
    fn: () => Navigator.pop(context),
    title: AppStrings.goBackTitle,
    content: AppStrings.goBackDescrption,
    noText: AppStrings.cancel,
    yesText: AppStrings.goBack,
    yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        _confirmGoBack(context);

        return Future.value(false);
      },
      child: AppScaffold(
        releaseFocus: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: AppLeadingAppBarWidget(onTap: () => _confirmGoBack(context)),
          title: AppAppBarTitle(AppStrings.changeCardPin),
        ),
        body: AppConstrainedScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              spacing: AppSpacing.lg,
              children: [
                VirtaulCardDetails(cardDetails: cardDetails),
                Gap.v(AppSpacing.lg),
                ChangeCardPinForm(),
                Gap.v(AppSpacing.xlg),
                ChangeCardPinButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
