import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/config.dart';

import '../cubit/register_cubit.dart';

class ReferralField extends StatefulWidget {
  const ReferralField({super.key});

  @override
  State<ReferralField> createState() => _ReferralFieldState();
}

class _ReferralFieldState extends State<ReferralField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();
  late final RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<RegisterCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _cubit.onReferralUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (RegisterCubit cubit) => cubit.state.status.isLoading,
    );

    final referralError = context.select(
      (RegisterCubit cubit) => cubit.state.referral.errorMessage,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // AppTextFieldLabel(AppStrings.password),
        AppTextField.underlineBorder(
          hintText: 'Referral (Optional)',
          prefixIcon: const Icon(
            Icons.person_add_alt,
            size: 24,
            color: AppColors.grey,
          ),
          filled: Config.filled,
          focusNode: _focusNode,
          errorText: referralError,
          enabled: !isLoading,
          textInputAction: TextInputAction.done,
          onChanged: (v) => _debouncer.run(() => _cubit.onReferralChanged(v)),
        ),
      ],
    );
  }
}
