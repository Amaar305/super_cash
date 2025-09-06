import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../vtupass.dart';

class CableForm extends StatefulWidget {
  const CableForm({super.key});

  @override
  State<CableForm> createState() => _CableFormState();
}

class _CableFormState extends State<CableForm> {
  @override
  void initState() {
    super.initState();
    context.read<CableCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CableCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CableCubit, CableState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(
        spacing: AppSpacing.xxlg,
        children: [
          CableCardProviderField(),
          CableCardNumberField(),
          CablePhoneField(),
          CableVTUButtons(),
        ],
      ),
    );
  }
}

class CableVTUButtons extends StatelessWidget {
  const CableVTUButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CableCubit c) => c.state.status.isLoading,
    );
    return VTUActionButtons(
      isLoading: isLoading,
      onContactPicked: (newValue) =>
          context.read<CableCubit>().onPhoneChanged(newValue),
      onNumberPasted: (newValue) =>
          context.read<CableCubit>().onPhoneChanged(newValue),
    );
  }
}

class CableForMySelfButton extends StatelessWidget {
  const CableForMySelfButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CableCubit element) => element.state.status.isLoading,
    );
    return AppMiniButton(
      isLoading: isLoading,
      label: AppStrings.beneficiary,
      onPressed: () => context.read<CableCubit>().onPhoneChanged('07075179929'),
    );
  }
}
