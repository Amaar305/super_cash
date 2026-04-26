import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DataGiveawayClaimButton extends StatelessWidget {
  const DataGiveawayClaimButton({super.key, required this.dataId});
  final String dataId;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (DataGiveawayCubit cubit) => cubit.state.status.isLoading,
    );

    return PrimaryButton(
      label: 'Claim',
      isLoading: isLoading,
      onPressed: () async {
        await context.read<DataGiveawayCubit>().claimData(
          dataId: dataId,
          onClaimed: (giveaway) => context.pop(giveaway),
        );
      },
    );
  }
}
