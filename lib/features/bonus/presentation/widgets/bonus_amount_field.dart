import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';

class BonusAmountField extends StatefulWidget {
  const BonusAmountField({super.key});

  @override
  State<BonusAmountField> createState() => _BonusAmountFieldState();
}

class _BonusAmountFieldState extends State<BonusAmountField> {
  late final TextEditingController _controller;
  late final BonusCubit _cubit;
  late final FocusNode _focusNode;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<BonusCubit>();
    _controller = TextEditingController(text: _cubit.state.amount.value)
      ..addListener(_onAmountChanged);
    _focusNode = FocusNode()..addListener(_onAmountfocused);
    _debouncer = Debouncer();
  }

  @override
  void didUpdateWidget(BonusAmountField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_cubit.state.amount.value != _controller.text) {
      _controller.text = _cubit.state.amount.value;
    }
  }

  void _onAmountChanged() {
    _debouncer.run(() {
      _cubit.onAmountChanged(_controller.text);
    });
  }

  void _onAmountfocused() {
    if (!_focusNode.hasFocus) {
      _cubit.onAmountFocused();
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onAmountChanged)
      ..dispose();
    _focusNode
      ..removeListener(_onAmountfocused)
      ..dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amountErrorMessage = context.select(
      (BonusCubit cubit) => cubit.state.amount.errorMessage,
    );
    final isLoading = context.select(
      (BonusCubit cubit) => cubit.state.status.isLoading,
    );
    final isBonus = context.select(
      (BonusCubit cubit) => cubit.state.isBonusWithdrawn,
    );
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.enterAmountToTransfer, style: poppinsTextStyle()),
        AppTextField.underlineBorder(
          hintText: AppStrings.enterAmount,
          focusNode: _focusNode,
          prefixIcon: const Icon(
            Icons.wallet_outlined,
            size: 24,
            color: AppColors.grey,
          ),
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          filled: Config.filled,
          enabled: !isLoading,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textController: _controller,
          errorText: amountErrorMessage,
          suffixIcon: SizedBox(
            height: 42,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.primary2,
                ),
                onPressed: () {
                  final bonus =
                      context.read<AppCubit>().state.user?.wallet.bonus ?? '0';

                  final sanitizedBonus = bonus.split('.').first;

                  if (sanitizedBonus.isEmpty) return;

                  if (isBonus) {
                    _controller
                      ..text = sanitizedBonus
                      ..selection = TextSelection.collapsed(
                        offset: sanitizedBonus.length,
                      );
                    _cubit.onAmountChanged(sanitizedBonus);
                  } else {
                    final amt = double.parse(sanitizedBonus) - 25;
                    final sn = amt.toInt().toString();

                    _controller
                      ..text = sn
                      ..selection = TextSelection.collapsed(offset: sn.length);
                    _cubit.onAmountChanged(sn);
                  }
                },
                child: Text(
                  'Max',
                  style: TextStyle(fontSize: 10, color: AppColors.white),
                ),
              ),
            ),
          ),
        ),
        EarningBonusOverview(),
      ],
    );
  }
}
