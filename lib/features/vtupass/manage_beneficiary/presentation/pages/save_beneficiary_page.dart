import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/entities.dart';
import '../presentation.dart';

class SaveBeneficiaryPage extends StatelessWidget {
  const SaveBeneficiaryPage({super.key, this.beneficiary});
  final Beneficiary? beneficiary;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SaveUpdateBeneficiaryCubit(
        saveBeneficiaryUseCase: serviceLocator(),
        updateBeneficiaryUseCase: serviceLocator(),
        beneficiary: beneficiary,
      ),
      child: SaveBeneficiaryView(beneficiary: beneficiary),
    );
  }
}

class SaveBeneficiaryView extends StatelessWidget {
  const SaveBeneficiaryView({super.key, this.beneficiary});
  final Beneficiary? beneficiary;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: _appBar(context),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          spacing: AppSpacing.xlg,
          children: [
            SaveBeneficiaryForm(),
            SaveBeneficiaryNetworkProvider(beneficiary: beneficiary),
            SizedBox(),
            SaveBeneficiaryButton(beneficiary: beneficiary),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: AppAppBarTitle(
        beneficiary == null || beneficiary!.id.isEmpty
            ? AppStrings.saveAsBeneficiary
            : AppStrings.updateAsBeneficiary,
      ),
      leading: AppLeadingAppBarWidget(onTap: context.pop),
    );
  }
}
