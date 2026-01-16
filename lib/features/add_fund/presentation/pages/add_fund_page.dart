import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation.dart';

class AddFundPage extends StatelessWidget {
  const AddFundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddFundCubit(generateAccountUseCase: serviceLocator()),
      child: AddFundView(),
    );
  }
}

class AddFundView extends StatelessWidget {
  const AddFundView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.addFunds),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSpacing.lg,
            children: [NewWidget(), FundingDetailsSection()],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final activeMethod = context.select(
      (AddFundCubit cubit) => cubit.state.activeFundingMethod,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Funding Method',
          style: poppinsTextStyle(
            fontSize: 12,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        AddFundFundingMethods(
          selectedIndex: activeMethod,
          onChanged: context.read<AddFundCubit>().onFundingMethodChanged,
        ),
      ],
    );
  }
}
