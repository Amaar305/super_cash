import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:super_cash/app/init/init.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../vtupass.dart';

class AirtimePage extends StatelessWidget {
  const AirtimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AirtimeCubit(airtimeUsecase: serviceLocator()),
      child: const AirtimeView(),
    );
  }
}

class AirtimeView extends StatelessWidget {
  const AirtimeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isVtuSell = context.select((AirtimeCubit c) => c.state.vtuSell);
    return AppScaffold(
      releaseFocus: true,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            AirtimeTabType(),
            if (isVtuSell)
              AirtimeVtuSellPage(key: ValueKey('vtusell'))
            else
              AirtimeShareAndSellPage(key: ValueKey('sharesell')),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: AppLeadingAppBarWidget(onTap: context.pop),
      title: AppAppBarTitle(AppStrings.buyAirtime),
    );
  }
}

class AirtimeVtuSellPage extends StatelessWidget {
  const AirtimeVtuSellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap.v(AppSpacing.lg),
        AirtimeForm(),
        AirtimeVTUButtons(),
        Gap.v(AppSpacing.spaceUnit),
        AirtimeButton(),
      ],
    );
  }
}
