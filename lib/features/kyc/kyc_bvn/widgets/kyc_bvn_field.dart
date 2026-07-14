import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/kyc/kyc_bvn/cubit/kyc_bvn_cubit.dart';

class KycBvnField extends StatefulWidget {
  const KycBvnField({super.key});

  @override
  State<KycBvnField> createState() => _KycBvnFieldState();
}

class _KycBvnFieldState extends State<KycBvnField> {
  late final KycBvnCubit _cubit;
  late final TextEditingController _controller;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<KycBvnCubit>();
    _controller = TextEditingController(text: _cubit.state.bvn)
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
    _debouncer.run(() => _cubit.onBvnChanged(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final error = context.select((KycBvnCubit c) => c.state.bvnError);
    final isSubmitting =
        context.select((KycBvnCubit c) => c.state.status.isSubmitting);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.lg,
      children: [
        const FieldLabelTitle('BVN'),
        AppTextField.underlineBorder(
          enabled: !isSubmitting,
          filled: Config.filled,
          prefixIcon: const AppPrefixIcon(Icons.verified_user_outlined),
          hintText: 'Enter your 11-digit BVN',
          textController: _controller,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          maxLength: 11,
          errorText: error,
        ),
      ],
    );
  }
}
