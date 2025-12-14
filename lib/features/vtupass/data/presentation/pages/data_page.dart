import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../vtupass.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataCubit(
        buyDataPlanUseCase: serviceLocator(),
        fetchDataPlanUseCase: serviceLocator(),
      ),
      child: DataView(),
    );
  }
}

class DataView extends StatelessWidget {
  const DataView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: AppLeadingAppBarWidget(onTap: context.pop),
        title: AppAppBarTitle(AppStrings.buyData),
      ),
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: DataViewSwitcher(),
      ),
    );
  }
}
