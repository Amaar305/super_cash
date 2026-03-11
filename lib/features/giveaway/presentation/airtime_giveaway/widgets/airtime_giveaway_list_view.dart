import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class AirtimeGiveawayListView extends StatelessWidget {
  const AirtimeGiveawayListView({super.key});

  @override
  Widget build(BuildContext context) {
    final pins = context.select(
      (AirtimeGiveawayCubit cubit) => cubit.state.giveawayPins,
    );

    if (pins.isEmpty) {
      return AppEmptyState(title: 'No available pins');
    }

    void onSuccess(AirtimeGiveawayPin giveawayPin) {
      context.pop();
      showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AirtimeGiveawaySuccessDialog(airtimeGiveawayPin: giveawayPin);
        },
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 12 / 10,
      ),
      itemCount: pins.length,
      itemBuilder: (context, index) {
        return AirtimeGiveawayCard(
          giveawayPin: pins[index],
          onClaimed: (planId) => context
              .read<AirtimeGiveawayCubit>()
              .claimAirtimeGiveaway(planId: planId, onSuccess: onSuccess),
        );
      },
    );
  }
}
