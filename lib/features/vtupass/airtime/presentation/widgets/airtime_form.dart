import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../airtime.dart';

class AirtimeForm extends StatefulWidget {
  const AirtimeForm({super.key});

  @override
  State<AirtimeForm> createState() => _AirtimeFormState();
}

class _AirtimeFormState extends State<AirtimeForm> {
  @override
  void initState() {
    super.initState();
    context.read<AirtimeCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AirtimeCubit>().resetState();
    logI('Reseting...');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AirtimeCubit, AirtimeState>(
      listenWhen: (previous, current) => current.status != previous.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(
        children: [
          AirtimeNetworkProviders(),
          Gap.v(AppSpacing.lg),
          AirtimeQuickAmount(),
          AirtimeAmountField(),
          Gap.v(AppSpacing.lg),
          Gap.v(AppSpacing.lg),
          AirtimePhoneField(),
          Gap.v(AppSpacing.xlg),
        ],
      ),
    );
  }
}
