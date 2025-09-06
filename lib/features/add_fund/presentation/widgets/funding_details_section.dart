import 'package:super_cash/features/add_fund/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundingDetailsSection extends StatelessWidget {
  const FundingDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final activeMethod = context.select(
      (AddFundCubit cubit) => cubit.state.activeFundingMethod,
    );
    final child = switch (activeMethod) {
      0 => BankTransferSection(),
      1 => OneTimeTransferSection(),
      2 => CardFundingSection(),
      _ => ManualFundingSection(),
    };
    return child;
  }
}
