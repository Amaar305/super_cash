import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/helper/fingerprint_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../presentation.dart';

typedef ConfirmTransactionPurchaseDetail = Widget;

class ConfirmTransactionPinPage extends StatefulWidget {
  const ConfirmTransactionPinPage({super.key, this.transactionPurchaseDetail});
  final ConfirmTransactionPurchaseDetail? transactionPurchaseDetail;

  @override
  State<ConfirmTransactionPinPage> createState() =>
      _ConfirmTransactionPinPageState();
}

class _ConfirmTransactionPinPageState extends State<ConfirmTransactionPinPage> {
  late final ConfirmTransactionPinCubit _cubit;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ConfirmTransactionPinCubit>();
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  void confirmGoBack(BuildContext context) => context.confirmAction(
    fn: () => context.pop(),
    title: AppStrings.goBackTitle,
    content: AppStrings.goBackDescrption,
    noText: AppStrings.cancel,
    yesText: AppStrings.goBack,
    yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
  );

  @override
  Widget build(BuildContext context) {
    // final isLoading = context.select(
    //   (ConfirmTransactionPinCubit cubit) => cubit.state.status.isLoading,
    // );
    return AppScaffold(
      appBar: AppBar(
        leading: AppLeadingAppBarWidget(onTap: () => confirmGoBack(context)),
        title: AppAppBarTitle(AppStrings.enterPin),
      ),
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      body:
          BlocListener<ConfirmTransactionPinCubit, ConfirmTransactionPinState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isError) {
                openSnackbar(
                  SnackbarMessage.error(title: state.message),
                  clearIfQueue: true,
                );
                return;
              } else if (state.status.isLoading) {
                openSnackbar(SnackbarMessage.loading(), clearIfQueue: true);
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  spacing: AppSpacing.spaceUnit,
                  children: [
                    VeryPurchaseWidget(),
                    if (widget.transactionPurchaseDetail != null)
                      widget.transactionPurchaseDetail as Widget,
                    BlocBuilder<
                      ConfirmTransactionPinCubit,
                      ConfirmTransactionPinState
                    >(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        {
                          return AppPinForm(
                            obscured: true,
                            enabled: !state.status.isLoading,
                            onChange: _cubit.onPinChanged,
                            onCompleted: (pin) {
                              _onVerified();
                            },
                            onFingerprintAuthentication: !state.status.isLoading
                                ? () async {
                                    await fingerprintAuthentication(
                                      onAuthenticated: _onVerified,
                                    );
                                  }
                                : null,
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

  void _onVerified() {
    _cubit.onVerifyPin(
      onVerified: (p0) {
        context.pop<bool?>(true);
      },
    );
  }
}
