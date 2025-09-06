import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/card/change_card_pin/presentation/cubit/change_card_pin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class ChangeCardPinForm extends StatefulWidget {
  const ChangeCardPinForm({super.key});

  @override
  State<ChangeCardPinForm> createState() => _ChangeCardPinFormState();
}

class _ChangeCardPinFormState extends State<ChangeCardPinForm> {
  @override
  void initState() {
    super.initState();
    context.read<ChangeCardPinCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeCardPinCubit, ChangeCardPinState>(
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(
        spacing: AppSpacing.xlg,
        children: [ChangeCardNewPinField(), ChangeCardConfirmPinField()],
      ),
    );
  }
}
