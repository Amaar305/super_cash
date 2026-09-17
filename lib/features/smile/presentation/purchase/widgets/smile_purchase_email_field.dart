import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/smile/presentation/purchase/purchase.dart';

class SmilePurchaseEmailField extends StatefulWidget {
  const SmilePurchaseEmailField({super.key});

  @override
  State<SmilePurchaseEmailField> createState() =>
      _SmilePurchaseEmailFieldState();
}

class _SmilePurchaseEmailFieldState extends State<SmilePurchaseEmailField> {
  late final SmilePurchaseCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SmilePurchaseCubit>();
    _debouncer = Debouncer();
    _controller = TextEditingController(text: _cubit.state.email.value);
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) _cubit.onEmailFocused();
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SmilePurchaseCubit c) => c.state.status.isLoading,
    );
    final isVerified = context.select(
      (SmilePurchaseCubit c) => c.state.isVerified,
    );
    final emailErrorMsg = context.select(
      (SmilePurchaseCubit c) => c.state.email.errorMessage,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          AppStrings.smileEmail,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        AppTextField.underlineBorder(
          enabled: !isLoading,
          hintText: AppStrings.enterSmileEmail,
          textController: _controller,
          focusNode: _focusNode,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          prefixIcon: const Icon(
            Icons.alternate_email,
            size: 24,
            color: AppColors.grey,
          ),
          suffixIcon: isVerified
              ? const Icon(Icons.check_circle, color: AppColors.green)
              : null,
          onChanged: (value) =>
              _debouncer.run(() => _cubit.onEmailChanged(value)),
          errorText: emailErrorMsg,
        ),
      ],
    );
  }
}
