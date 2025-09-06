import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../../../../../core/cooldown/cooldown.dart';
import '../../card_withdraw.dart';

class CardWithdrawButton extends StatefulWidget {
  const CardWithdrawButton({super.key});

  @override
  State<CardWithdrawButton> createState() => _CardWithdrawButtonState();
}

class _CardWithdrawButtonState extends State<CardWithdrawButton> {
  late final Debouncer _debouncer;
  late final CardWithdrawCubit _cubit;
  late final CooldownCubit _cooldownCubit;

  final Duration cooldown = Duration(minutes: 5);
  final String actionKey = CooldownKeys.withdrawCard;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CardWithdrawCubit>();
    _cooldownCubit = context.read<CooldownCubit>();
    _debouncer = Debouncer();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CardWithdrawCubit cubit) => cubit.state.status.isLoading,
    );
    return PrimaryButton(
      label: AppStrings.withdraw,
      isLoading: isLoading,
      onPressed: () => _debouncer.run(() async {
        final result = await context.push<bool?>(AppRoutes.confirmationDialog);

        if (result == false && !context.mounted) return;

        _cubit.onSubmit((p0) {
          _cooldownCubit.startCooldown(actionKey, cooldown); //Start cooldown
          context.showConfirmationBottomSheet(
            title: 'Card withdraw succssfully initiated',
            okText: AppStrings.done,
            description: p0.description,
          );
        });
      }),
    );
  }
}
