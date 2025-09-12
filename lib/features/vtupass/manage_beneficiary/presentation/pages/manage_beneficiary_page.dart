import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManageBeneficiaryPage extends StatelessWidget {
  const ManageBeneficiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<ManageBeneficiaryCubit>()
        ..fetchBeneficiaries(forceReload: true),
      child: const ManageBeneficiaryView(),
    );
  }
}

class ManageBeneficiaryView extends StatelessWidget {
  const ManageBeneficiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: ManageBeneficiaryBody(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: AppAppBarTitle(AppStrings.manageBeneficiary),
      actions: [
        IconButton(
          onPressed: () => context.goNamedSafe(RNames.saveBeneficiary),
          icon: Icon(Icons.add, size: 24),
        ),
      ],
      leading: AppLeadingAppBarWidget(onTap: context.pop),
    );
  }
}

class ManageBeneficiaryBody extends StatelessWidget {
  const ManageBeneficiaryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageBeneficiaryCubit, ManageBeneficiaryState>(
      listenWhen: (previous, current) => current.status.isFailure,
      buildWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure && state.message.isNotEmpty) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      builder: (context, state) {
        if (_shouldShowLoading(state)) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.status == ManageBeneficiaryStatus.failure &&
            state.beneficiaries.isEmpty) {
          return _buildFailureState(context, state.message);
        }
        return ManageBeneficiaryListView(
          beneficiaries: state.beneficiaries,
          hasReachMax: state.hasReachedMax,
        );
      },
    );
  }

  bool _shouldShowLoading(ManageBeneficiaryState state) {
    return state.status == ManageBeneficiaryStatus.initial ||
        (state.status == ManageBeneficiaryStatus.loading &&
            state.beneficiaries.isEmpty);
  }

  Widget _buildFailureState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () =>
                context.read<ManageBeneficiaryCubit>().refreshTransactions(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
