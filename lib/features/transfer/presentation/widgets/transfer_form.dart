import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class TransferForm extends StatefulWidget {
  const TransferForm({super.key});

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  @override
  void initState() {
    super.initState();
    context.read<TransferCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TransferCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferCubit, TransferState>(
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: '', description: state.message),
            clearIfQueue: true,
          );
        }
        if (state.status.isSuccess) {
          context.showConfirmationBottomSheet(
            title: 'Transfer Successful',
            okText: AppStrings.done,
            description: 'Your transfer was successfully processed.',
          );
        }
      },
      child: Column(
        spacing: AppSpacing.xlg,
        children: [
          TransferBankDropField(),
          TransferAccountNumberField(),
          TransferAdditionalWidget(),
        ],
      ),
    );
  }
}

class TransferAdditionalWidget extends StatelessWidget {
  const TransferAdditionalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isInitial = context.select(
      (TransferCubit cubit) => cubit.state.status.isInitial,
    );
    final bankDetail = context.select(
      (TransferCubit cubit) => cubit.state.bankDetail,
    );
    return AnimatedCrossFade(
      firstChild: Column(
        spacing: AppSpacing.xlg,
        children: [
          TransferValidatedDetails(key: ValueKey('validatedDetails')),
          TransferAmountField(key: ValueKey('amountField')),
        ],
      ),
      secondChild: SizedBox.shrink(),
      crossFadeState: !isInitial && bankDetail != null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Durations.medium1,
    );
  }
}
