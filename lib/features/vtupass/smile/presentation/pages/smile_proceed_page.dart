import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation.dart';

class SmileProceedPage extends StatelessWidget {
  const SmileProceedPage({super.key, required this.cubit});

  final SmileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: cubit, child: SmileProceedView());
  }
}

class SmileProceedView extends StatelessWidget {
  const SmileProceedView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.smile),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          spacing: AppSpacing.xlg,
          children: [
            SmileTab(),
            SmileVoiceTile(),
            SmileForm(),
            SmileProceedButton(),
          ],
        ),
      ),
    );
  }
}
