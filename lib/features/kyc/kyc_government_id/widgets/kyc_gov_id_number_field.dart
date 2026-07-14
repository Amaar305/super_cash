import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/kyc/kyc_government_id/cubit/kyc_government_id_cubit.dart';

class KycGovIdNumberField extends StatefulWidget {
  const KycGovIdNumberField({super.key});

  @override
  State<KycGovIdNumberField> createState() => _KycGovIdNumberFieldState();
}

class _KycGovIdNumberFieldState extends State<KycGovIdNumberField> {
  late final KycGovernmentIdCubit _cubit;
  late final TextEditingController _controller;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<KycGovernmentIdCubit>();
    _controller =
        TextEditingController(text: _cubit.state.documentNumber)
          ..addListener(_onChanged);
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  void _onChanged() {
    _debouncer.run(
      () => _cubit.onDocumentNumberChanged(_controller.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final error = context.select(
      (KycGovernmentIdCubit c) => c.state.documentNumberError,
    );
    final isUploading = context.select(
      (KycGovernmentIdCubit c) => c.state.status.isUploading,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.lg,
      children: [
        const FieldLabelTitle('Document Number'),
        AppTextField.underlineBorder(
          enabled: !isUploading,
          filled: Config.filled,
          hintText: 'Enter document number',
          textController: _controller,
          textInputAction: TextInputAction.done,
          errorText: error,
        ),
      ],
    );
  }
}
