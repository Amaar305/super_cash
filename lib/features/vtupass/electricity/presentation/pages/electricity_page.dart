import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ElectricityPage extends StatelessWidget {
  const ElectricityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ElectricityCubit(
        getElectricityPlansUseCase: serviceLocator(),
        purchaseElectricityPlanUseCase: serviceLocator(),
        validateElectricityPlanUseCase: serviceLocator(),
      ),
      child: ElectricityView(),
    );
  }
}

class ElectricityView extends StatefulWidget {
  const ElectricityView({super.key});

  @override
  State<ElectricityView> createState() => _ElectricityViewState();
}

class _ElectricityViewState extends State<ElectricityView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ElectricityCubit>().onStart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.electricity),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          ElectricityTypeTab(),
          Gap.v(AppSpacing.xlg),
          ElectricityForm(),
          Gap.v(AppSpacing.xlg),
          ElectricityVTUButtons(),
          Gap.v(AppSpacing.xlg),
          ElectricityButton(),
        ],
      ),
    );
  }
}

class ElectricityVTUButtons extends StatelessWidget {
  const ElectricityVTUButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ElectricityCubit c) => c.state.status.isLoading,
    );
    return VTUActionButtons(
      isLoading: isLoading,
      onContactPicked: (newValue) =>
          context.read<ElectricityCubit>().onPhoneChanged(newValue),
      onNumberPasted: (newValue) =>
          context.read<ElectricityCubit>().onPhoneChanged(newValue),
      onBeneficiaryTapped: (beneficiary) {
        if (beneficiary == null) return;

        context.read<ElectricityCubit>().onPhoneChanged(beneficiary.phone);
      },
    );
  }
}
