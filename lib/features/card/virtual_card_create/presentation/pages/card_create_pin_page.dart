// ignore_for_file: deprecated_member_use

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../card.dart';

class CardCreatePinPage extends StatelessWidget {
  const CardCreatePinPage({super.key, required this.cardCubit});
  final CreateVirtualCardCubit cardCubit;

  static route({required CreateVirtualCardCubit cardCubit}) =>
      MaterialPageRoute(
        builder: (_) => CardCreatePinPage(cardCubit: cardCubit),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cardCubit,
      child: CardCreatePinView(),
    );
  }
}

class CardCreatePinView extends StatelessWidget {
  const CardCreatePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _confirmAlertDialog(context);
        return Future.value(false);
      },
      child: AppScaffold(
        releaseFocus: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: AppLeadingAppBarWidget(
            onTap: () => _confirmAlertDialog(context),
          ),
          title: AppAppBarTitle(AppStrings.setYourCardPin),
        ),
        body: AppConstrainedScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              spacing: AppSpacing.xxlg,
              children: [
                CardCreatePinForm(),
                Gap.v(AppSpacing.xlg),
                CreateCardPinProcessButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmAlertDialog(BuildContext context) => context.confirmAction(
        fn: () => Navigator.pop(context),
        title: AppStrings.goBackTitle,
        content: AppStrings.goBackDescrption,
        noText: AppStrings.cancel,
        yesText: AppStrings.goBack,
        yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
      );
}

class CreateCardPinProcessButton extends StatelessWidget {
  const CreateCardPinProcessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select((CreateVirtualCardCubit cubit) => cubit.state.status.isLoading);
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.proceed,
      onPressed: () {
        context.read<CreateVirtualCardCubit>().onProceed(
          () {
            Navigator.push(
              context,
              CardCreateCostAndChargesPage.route(
                  cardCubit: context.read<CreateVirtualCardCubit>()),
            );
          },
        );
      },
    );
  }
}
