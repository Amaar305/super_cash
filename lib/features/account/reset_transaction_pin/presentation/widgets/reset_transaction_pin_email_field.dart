import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';

class ResetTransactionPinEmailField extends StatefulWidget {
  const ResetTransactionPinEmailField({super.key});

  @override
  State<ResetTransactionPinEmailField> createState() =>
      _ResetTransactionPinEmailFieldState();
}

class _ResetTransactionPinEmailFieldState
    extends State<ResetTransactionPinEmailField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    final email = context.read<AppBloc>().state.user.email;
    controller = TextEditingController(text: email);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        Text(
          AppStrings.emailAddress,
          style: TextStyle(
            fontWeight: AppFontWeight.medium,
            fontSize: AppSpacing.md,
          ),
        ),
        AppTextField.underlineBorder(
          enabled: false,
          filled: Config.filled,
          textController: controller,
          hintText: AppStrings.emailAddress,
          prefixIcon: Icon(Icons.email_outlined, size: AppSpacing.xxlg / 2),
        ),
      ],
    );
  }
}
