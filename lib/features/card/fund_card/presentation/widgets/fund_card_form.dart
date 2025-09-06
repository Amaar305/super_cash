import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../card.dart';

class FundCardForm extends StatefulWidget {
  const FundCardForm({super.key});

  @override
  State<FundCardForm> createState() => _FundCardFormState();
}

class _FundCardFormState extends State<FundCardForm> {
  @override
  void initState() {
    super.initState();
    context.read<FundCardCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<FundCardCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FundCardCubit, FundCardState>(
      listenWhen: (previous, current) => current.status != previous.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(children: [FundCardAmountField()]),
    );
  }
}
