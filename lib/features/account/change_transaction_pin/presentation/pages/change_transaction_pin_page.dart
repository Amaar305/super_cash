import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/account/change_transaction_pin/change_transaction_pin.dart';

class ChangeTransactionPinPage extends StatelessWidget {
  const ChangeTransactionPinPage({super.key});

  static route() =>
      MaterialPageRoute(builder: (_) => ChangeTransactionPinPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeTransactionPinCubit(
        updateTransactionPinUseCase: serviceLocator(),
      ),
      child: ChangeTransactionPinView(),
    );
  }
}

class ChangeTransactionPinView extends StatelessWidget {
  const ChangeTransactionPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.changeTransactionPin),
        leading: AppLeadingAppBarWidget(onTap: () => Navigator.pop(context)),
      ),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              ChangeTransactionPinForm(),
              Gap.v(AppSpacing.xxxlg),
              ChangeTransactionPinButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeTransactionPinButton extends StatelessWidget {
  const ChangeTransactionPinButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ChangeTransactionPinCubit element) => element.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.change,
      onPressed: () {
        context.read<ChangeTransactionPinCubit>().submit((result) {
          context.showConfirmationBottomSheet(
            title: 'Transaction PIN Changed!',
            okText: 'Done',
            description: result,

            onDone: () {
              context
                ..pop()
                ..pop();
            },
          );
        });
      },
    );
  }
}
