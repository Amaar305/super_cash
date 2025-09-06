import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../card_withdraw.dart';

class CardWithdrawForm extends StatefulWidget {
  const CardWithdrawForm({super.key});

  @override
  State<CardWithdrawForm> createState() => _CardWithdrawFormState();
}

class _CardWithdrawFormState extends State<CardWithdrawForm> {
  @override
  void initState() {
    super.initState();
    context.read<CardWithdrawCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CardWithdrawCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardWithdrawCubit, CardWithdrawState>(
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(children: [CardWithdrawAmountField()]),
    );
  }
}
