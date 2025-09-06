import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../../../../../core/cooldown/cooldown.dart';

class FundCardButton extends StatefulWidget {
  const FundCardButton({super.key});

  @override
  State<FundCardButton> createState() => _FundCardButtonState();
}

class _FundCardButtonState extends State<FundCardButton> {
  late final Debouncer _debouncer;

  late final FundCardCubit _cubit;
  late final CooldownCubit _cooldownCubit;

  final Duration cooldown = Duration(minutes: 5);
  final String actionKey = CooldownKeys.fundCard;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FundCardCubit>();
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
      (FundCardCubit cubit) => cubit.state.status.isLoading,
    );
    return PrimaryButton(
      label: AppStrings.fundCard,
      isLoading: isLoading,
      onPressed: () async {
        final result = await context.push(AppRoutes.confirmationDialog);

        if (result == true && context.mounted) {
          _debouncer.run(
            () => _cubit.onSubmit((transaction) {
              _cooldownCubit.startCooldown(
                actionKey,
                cooldown,
              ); //Start cooldown
              context.showConfirmationBottomSheet(
                title: 'Card Funding Initiated',
                description: transaction.description,
                okText: AppStrings.done,
              );
            }),
          );
        }
      },
    );
  }
}
