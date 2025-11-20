import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/account/reset_transaction_pin/presentation/pages/reset_transaction_pin/reset_pin_transaction_page.dart';
import 'package:super_cash/features/account/reset_transaction_pin/presentation/presentation.dart';
import 'package:super_cash/features/account/reset_transaction_pin/presentation/widgets/reset_transaction_pin_email_field.dart';

class ResetTransactionPinPage extends StatelessWidget {
  const ResetTransactionPinPage({super.key});

  static route() =>
      MaterialPageRoute(builder: (_) => ResetTransactionPinPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetTransactionPinCubit(
        resetTransactionPinUseCase: serviceLocator(),
        requestTransactionPinOtpUseCase: serviceLocator(),
        user: context.read<AppCubit>().state.user ?? AppUser.anonymous,
      ),
      child: ResetTransactionPinView(),
    );
  }
}

class ResetTransactionPinView extends StatelessWidget {
  const ResetTransactionPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.resetTransactionPin),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: BlocListener<ResetTransactionPinCubit, ResetTransactionPinState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isFailure && state.message.isNotEmpty) {
                openSnackbar(
                  SnackbarMessage.error(title: state.message),
                  clearIfQueue: true,
                );
              }
            },
            child: Column(
              children: [
                PurchaseContainerInfo(
                  child: Text(
                    "To reset your PIN, we'll send a verification code to the email address below to confirm your request.",
                    style: TextStyle(
                      fontSize: AppSpacing.md,
                      color: AppColors.deepBlue,
                    ),
                  ),
                ),
                Gap.v(AppSpacing.lg),
                ResetTransactionPinEmailField(),
                Gap.v(AppSpacing.xxxlg),
                ButtonToRequestOTP(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonToRequestOTP extends StatelessWidget {
  const ButtonToRequestOTP({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ResetTransactionPinCubit element) => element.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.submit,
      onPressed: () {
        final cubit = context.read<ResetTransactionPinCubit>();

        cubit.requestOtp(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ResetPinTransactionPage(cubit: cubit),
            ),
          );
        });
      },
    );
  }
}
