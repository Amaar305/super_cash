import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation.dart';

class CablePage extends StatelessWidget {
  const CablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CableCubit(
        buyCableUseCase: serviceLocator(),
        fetchCablePlanUseCase: serviceLocator(),
        validateCableUsecase: serviceLocator(),
      ),
      child: CableView(),
    );
  }
}

class CableView extends StatelessWidget {
  const CableView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.cableSubscription),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          spacing: AppSpacing.xlg,
          children: [CableServiceProvider(), CableForm(), CableButton()],
        ),
      ),
    );
  }
}
