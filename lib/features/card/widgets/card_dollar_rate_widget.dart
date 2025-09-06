import 'package:super_cash/features/card/card.dart';
import 'package:super_cash/features/card/card_repo/cubit/card_repo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardDollarRateWidget extends StatelessWidget {
  const CardDollarRateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dollarRate = context.select(
      (CardRepoCubit cubit) => cubit.state.dollarRate?.dollarRate ?? 0,
    );
    return CardDetailContainer(
      text: 'Today Current Exchange Rate: ',
      text2: '\$1 - N$dollarRate',
    );
  }
}
