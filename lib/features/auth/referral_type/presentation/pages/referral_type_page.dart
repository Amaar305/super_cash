import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/init/init.dart';

import 'package:super_cash/features/auth/referral_type/presentation/presentation.dart';

class ReferralTypePage extends StatelessWidget {
  const ReferralTypePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => ReferralTypePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReferralTypeCubit(
        enrolCompainUseCase: serviceLocator(),
        fetchCompainsUseCase: serviceLocator(),
      ),
      child: ReferralTypeView(),
    );
  }
}

class ReferralTypeView extends StatefulWidget {
  const ReferralTypeView({super.key});

  @override
  State<ReferralTypeView> createState() => _ReferralTypeViewState();
}

class _ReferralTypeViewState extends State<ReferralTypeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReferralTypeCubit>().fetchCampaigns();
    });
  }

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
          children: const [
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
