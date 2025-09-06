import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class UpgradeTierPage extends StatelessWidget {
  const UpgradeTierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpgradeTierCubit(
        upgradeAccountUseCase: serviceLocator(),
        appBloc: context.read<AppBloc>(),
        checkUpgradeStatusUseCase: serviceLocator(),
      ),
      child: UpgradeTierView(),
    );
  }
}

class UpgradeTierView extends StatelessWidget {
  const UpgradeTierView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: UpgradeTierAppBarTitle(),
        leading: UpgradeTierAppBarLeadingWidget(),
      ),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.xlg,
          children: [UpgradeTierStepper(), UpgradeTierCurrentPage()],
        ),
      ),
    );
  }
}
