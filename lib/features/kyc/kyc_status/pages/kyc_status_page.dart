import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/kyc/kyc_status/cubit/kyc_status_cubit.dart';
import 'package:super_cash/features/kyc/kyc_status/widgets/widgets.dart';

class KycStatusPage extends StatelessWidget {
  const KycStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KycStatusCubit(
        getKycStatusUseCase: serviceLocator(),
        registerCardholderUseCase: serviceLocator(),
      )..getKycStatus(),
      child: const KycStatusView(),
    );
  }
}

class KycStatusView extends StatelessWidget {
  const KycStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<KycStatusCubit, KycStatusState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status &&
          (curr.status.isRegistered || curr.status.isFailure),
      listener: (context, state) {
        if (state.status.isRegistered) {
          openSnackbar(SnackbarMessage.success(title: state.message));
        }
        if (state.status.isFailure) {
          openSnackbar(SnackbarMessage.error(title: state.message));
        }
      },
      child: AppScaffold(
        appBar: AppBar(title: AppAppBarTitle('Super Cash')),
        body: BlocBuilder<KycStatusCubit, KycStatusState>(
          buildWhen: (prev, curr) =>
              curr.status.isInitial ||
              curr.status.isLoading ||
              curr.status.isSuccess ||
              curr.status.isFailure,
          builder: (context, state) {
            if (state.status.isLoading || state.status.isInitial) {
              return const Center(child: ThineCircularProgress());
            }
            if (state.status.isFailure && state.kycStatus == null) {
              return _ErrorBody(message: state.message, context: context);
            }
            return _SuccessBody(state: state);
          },
        ),
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.context});

  final String message;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xlg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 40,
              color: context.adaptiveColor.withValues(alpha: 0.4),
            ),
            const Gap.v(AppSpacing.sm),
            Text(
              message.isNotEmpty ? message : 'Failed to load KYC status.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: context.adaptiveColor.withValues(alpha: 0.6),
              ),
            ),
            const Gap.v(AppSpacing.lg),
            TextButton(
              onPressed: () => context.read<KycStatusCubit>().getKycStatus(),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessBody extends StatelessWidget {
  const _SuccessBody({required this.state});

  final KycStatusState state;

  Future<void> _onStepTap(BuildContext context, KycStepItem step) async {
    final cubit = context.read<KycStatusCubit>();
    switch (step.number) {
      case 1:
        await context.pushNamed(RNames.kycPersonalInfo);
      case 2:
        await context.pushNamed(RNames.kycHomeAddress);
      case 3:
        await context.pushNamed(RNames.kycSelfie);
      case 4:
        await context.pushNamed(RNames.kycGovernmentId);
      case 5:
        await context.pushNamed(RNames.kycBvn);
      default:
        return;
    }
    cubit.silentRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () => context.read<KycStatusCubit>().getKycStatus(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xlg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PageHeader(),
            const Gap.v(AppSpacing.xlg),
            KycProgressCard(
              progressLabel: state.progressLabel,
              progressValue: state.progressValue,
            ),
            const Gap.v(AppSpacing.xlg),
            KycStepsList(
              steps: state.stepItems,
              onStepTap: (step) => _onStepTap(context, step),
            ),
            const Gap.v(AppSpacing.xxlg),
            KycActivateButton(
              canActivate: state.canActivate,
              completedCount: state.completedStepsCount,
              totalSteps: state.totalSteps,
              onPressed: () =>
                  context.read<KycStatusCubit>().registerCardholder(),
            ),
            const Gap.v(AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Identity Verification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: AppFontWeight.bold,
            color: context.adaptiveColor,
          ),
        ),
        const Gap.v(AppSpacing.xs),
        Text(
          'Verify your identity to unlock full features.',
          style: TextStyle(
            fontSize: 14,
            color: context.adaptiveColor.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}
