import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/app_network_provider_widget.dart';
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
        beneficiary == null
            ? AppStrings.saveAsBeneficiary
            : AppStrings.updateAsBeneficiary,
      ),
      leading: AppLeadingAppBarWidget(onTap: context.pop),
    );
  }
}

class SaveBeneficiaryNetworkProvider extends StatelessWidget {
  const SaveBeneficiaryNetworkProvider({super.key, required this.beneficiary});

  final Beneficiary? beneficiary;

  @override
  Widget build(BuildContext context) {
    final selectedNetwork = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.network,
    );
    final isLoading = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.status.isLoading,
    );
    final networkErrorMsg = context.select(
      (SaveUpdateBeneficiaryCubit cubit) => cubit.state.networkErrorMsg,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        AppNetworkProviderWidget(
          onNetworkSelect: isLoading
              ? null
              : context.read<SaveUpdateBeneficiaryCubit>().onNetworkChanged,
          selectedNetwork: selectedNetwork,
        ),
        if (networkErrorMsg != null && networkErrorMsg.isNotEmpty)
          Text(
            networkErrorMsg,
            style: context.bodySmall?.copyWith(color: AppColors.red),
          ),
      ],
    );
  }
}
