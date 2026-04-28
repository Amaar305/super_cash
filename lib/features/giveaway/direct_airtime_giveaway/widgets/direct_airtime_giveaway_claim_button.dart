import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DirectAirtimeGiveawayClaimButton extends StatelessWidget {
  const DirectAirtimeGiveawayClaimButton({super.key, required this.airtimeId});
  final String airtimeId;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (DirectAirtimeGiveawayCubit cubit) => cubit.state.status.isLoading,
    );

    return PrimaryButton(
      label: 'Send',
      isLoading: isLoading,
      onPressed: () async {
        await context.read<DirectAirtimeGiveawayCubit>().addDirectAirtimePhone(
          airtimeId,
          onAdded: (giveaway) => context.pop(giveaway),
        );
      },
    );
  }
}
