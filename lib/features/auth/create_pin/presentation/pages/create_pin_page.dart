import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePinPage extends StatelessWidget {
  const CreatePinPage({super.key});

  static Route<void> route() => PageRouteBuilder(
    pageBuilder: (_, __, ___) => const CreatePinPage(),
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePinCubit(createPinUseCase: serviceLocator()),
      child: CreatePinView(),
    );
  }
}

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key});

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
        appBar: _appBar(context),
        body: AppConstrainedScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
            child: Column(
              spacing: AppSpacing.xxxlg,
              children: [
                Gap.v(AppSpacing.xs),
                CreatePinForm(),
                CreatePinButton(),
                CreatePinAssistanceButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    leading: AppLeadingAppBarWidget(onTap: () => _confirmGoBack(context)),
    title: Text(
      AppStrings.createTransactionPin,
      style: TextStyle(fontWeight: AppFontWeight.semiBold, fontSize: 16),
    ),
  );
}
