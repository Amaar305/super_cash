import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/features/add_fund/add_fund.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankTransferSection extends StatelessWidget {
  const BankTransferSection({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = context.select(
      (AppBloc cubit) => cubit.state.user.accounts,
    );
    return Column(
      spacing: AppSpacing.lg,
      children: [
        Text('Account Numbers', style: context.bodySmall),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: accounts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final bank = accounts[index];

            return BankDetailCard(
              bankDetail: bank,
              label: 'Account ${index + 1}',
            );
          },
        ),
        PrimaryButton(
          label: 'Generate more accounts.',
          onPressed: () {
            context.goNamedSafe(RNames.generateAccount);
          },
        ),
      ],
    );
  }
}
