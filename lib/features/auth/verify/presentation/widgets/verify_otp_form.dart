import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../verify.dart';

class VerifyOtpForm extends StatefulWidget {
  const VerifyOtpForm({super.key});

  @override
  State<VerifyOtpForm> createState() => _VerifyOtpFormState();
}

class _VerifyOtpFormState extends State<VerifyOtpForm> {
  @override
  void initState() {
    super.initState();
    context.read<VerifyCubit>().resetState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<VerifyCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyCubit, VerifyState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
        if (state.status.isSuccess) {
          openSnackbar(
            SnackbarMessage.success(title: state.response?['message']),
            clearIfQueue: true,
          );
        }
      },
      child: VerifyOtpField(),
    );
  }
}
