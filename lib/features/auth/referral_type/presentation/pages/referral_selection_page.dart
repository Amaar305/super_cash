import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/features/auth/referral_type/presentation/widgets/referral_type_terms_and_condition.dart';
import 'package:super_cash/features/auth/referral_type/referral_type.dart';

class ReferralSelectionPage extends StatelessWidget {
  const ReferralSelectionPage({super.key, required this.cubit});
  final ReferralTypeCubit cubit;

  static Route<void> route(ReferralTypeCubit cubit) {
    return MaterialPageRoute<void>(
      builder: (_) => ReferralSelectionPage(cubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: cubit, child: ReferralSelectionView());
  }
}

class ReferralSelectionView extends StatelessWidget {
  const ReferralSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Select Referral Type')),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: BlocListener<ReferralTypeCubit, ReferralTypeState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isFailure && state.message.isNotEmpty) {
              openSnackbar(SnackbarMessage.error(title: state.message));
            }
          },
          child: Column(
            spacing: AppSpacing.lg,
            children: [
              ReferralSelectionHeader(),
              Expanded(child: ReferralSelectionListView()),
              ReferralTypeTermsAndCondition(),
              ReferralSelectionButton(),
            ],
          ),
        ),
      ),
    );
  }
}
