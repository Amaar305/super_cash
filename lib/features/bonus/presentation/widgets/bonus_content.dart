import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';

class BonusContent extends StatelessWidget {
  const BonusContent({super.key});

  @override
  Widget build(BuildContext context) {
    final tabValue = context.select(
      (BonusCubit element) => element.state.isBonusWithdrawn,
    );
    return BlocListener<BonusCubit, BonusState>(
      listenWhen: (previous, current) => current.status != previous.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
          return;
        }

        if (state.status.isWithdrawn) {
          context.showConfirmationBottomSheet(
            title: 'Successfully withdrawn',
            okText: 'Done',
            description:
                'You have successfully withdrawn ${state.amount.value} Naira to wallet balance.',
          );
        }
        if (state.status.isTransferred) {
          context.showConfirmationBottomSheet(
            title: 'Successfully transferred',
            okText: 'Done',
            description:
                'You have successfully transferred ${state.amount.value} Naira to ${state.bankValidationResult?.accountName} ${state.selectedBank?.bankName}.',
          );
        }
      },
      child: AnimatedSwitcher(
        duration: 300.ms,
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: tabValue
            ? const WithdrawBonusView()
            : const TransferToBankView(),
      ),
    );
  }
}
