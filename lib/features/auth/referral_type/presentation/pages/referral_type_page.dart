import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:super_cash/features/auth/referral_type/presentation/presentation.dart';

class ReferralTypePage extends StatelessWidget {
  const ReferralTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReferralTypeCubit(),
      child: ReferralTypeView(),
    );
  }
}

class ReferralTypeView extends StatelessWidget {
  const ReferralTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Referral Type')),
      body: AppConstrainedScrollView(
        mainAxisAlignment: MainAxisAlignment.center,

        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.xxlg,
          children: [
            ReferralTypeHeader(),

            ReferralOptions(),
            Gap.v(AppSpacing.xxlg),
            ReferralTypeButton(),
          ],
        ),
      ),
    );
  }
}
