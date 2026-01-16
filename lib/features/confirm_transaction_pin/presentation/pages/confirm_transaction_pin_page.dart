import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/helper/fingerprint_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/account/reset_transaction_pin/reset_transaction_pin.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';

class ConfirmTransactionPinPage extends StatefulWidget {
  const ConfirmTransactionPinPage({super.key, this.purchaseDetail});

  final PurchaseDetail? purchaseDetail;

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
    return AppScaffold(
      appBar: AppBar(
        leading: AppLeadingAppBarWidget(onTap: () => confirmGoBack(context)),
        title: AppAppBarTitle(AppStrings.enterPin),
      ),
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      bottomSheet: ConfirmBottomFingerprint(
        onVerified: () async {
          await fingerprintAuthentication(
            onAuthenticated: () => _onVerified(true),
            onUnAuthenticated: (reason) {
              openSnackbar(
                SnackbarMessage.error(title: reason),
                clearIfQueue: true,
              );
            },
          );
        },
      ),
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
                  spacing: AppSpacing.lg,
                  children: [
                    // Details
                    if (widget.purchaseDetail != null)
                      PurchaseConfirmation(
                        amount: widget.purchaseDetail!.amount,
                        title: widget.purchaseDetail!.title,
                        description: widget.purchaseDetail!.description,
                        purchaseType: widget.purchaseDetail!.purchaseType,
                      ),

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
                            onForgotPinPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetTransactionPinPage(),
                              ),
                            ),
                            onFingerprintAuthentication: () async {
                              await fingerprintAuthentication(
                                onAuthenticated: () => _onVerified(true),
                                onUnAuthenticated: (reason) {
                                  openSnackbar(
                                    SnackbarMessage.error(title: reason),
                                    clearIfQueue: true,
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: AppSpacing.xxxlg),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  void _onVerified([bool withFingerprintAuthentication = false]) {
    if (withFingerprintAuthentication) {
      context.pop<bool?>(true);
      return;
    }
    _cubit.onVerifyPin(
      onVerified: (p0) {
        context.pop<bool?>(true);
      },
    );
  }
}
