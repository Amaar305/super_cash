import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/account/account.dart';
import 'package:super_cash/features/account/reset_transaction_pin/presentation/widgets/reset_transaction_confirm_pin.dart';
import 'package:super_cash/features/account/reset_transaction_pin/presentation/widgets/reset_transaction_new_pin.dart';
import 'package:super_cash/features/account/reset_transaction_pin/presentation/widgets/reset_transaction_otp.dart';
import 'package:super_cash/features/account/reset_transaction_pin/presentation/widgets/reset_transaction_pin_button.dart';

class ResetPinTransactionPage extends StatelessWidget {
  const ResetPinTransactionPage({super.key, required this.cubit});
  final ResetTransactionPinCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: cubit, child: ResetPinTransactionView());
  }
}

class ResetPinTransactionView extends StatelessWidget {
  const ResetPinTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.resetTransactionPin),
        leading: AppLeadingAppBarWidget(onTap: () => Navigator.pop(context)),
      ),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              ResetTransactionPinForm(),
              Gap.v(AppSpacing.xxxlg),
              ResetTransactionPinButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetTransactionPinForm extends StatelessWidget {
  const ResetTransactionPinForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetTransactionPinCubit, ResetTransactionPinState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure && state.message.isNotEmpty) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(
        spacing: AppSpacing.xlg,

        children: [
          ResetTransactionOtp(),
          ResetTransactionNewPin(),
          ResetTransactionConfirmPin(),
        ],
      ),
    );
  }
}
