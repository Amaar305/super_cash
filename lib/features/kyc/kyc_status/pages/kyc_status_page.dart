import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/kyc/domain/models/kyc_models.dart';
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
          (prev.status != curr.status &&
              (curr.status.isRegistered || curr.status.isFailure)) ||
          prev.kycStatus != curr.kycStatus,
      listener: (context, state) {
        if (state.status.isRegistered) {
          openSnackbar(SnackbarMessage.success(title: state.message));
          _syncUserAfterRegistration(context, state.cardholder);
        }
        if (state.status.isFailure) {
          openSnackbar(SnackbarMessage.error(title: state.message));
        }
        // Catches upgrades that landed via webhook (async, no response for
        // registerCardholder() to react to) — picked up the next time this
        // screen fetches/refreshes the KYC status.
        _syncUserFromKycStatus(context, state.kycStatus);
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

  // Mirrors CardholderService._update_user_tier_from_provider: provider
  // tier >= 2 means full KYC, so the user is bumped to tier two. Reaching
  // `registered` at all already implies KYC was verified, since the
  // activate button is only enabled once every step is complete.
  void _syncUserAfterRegistration(
    BuildContext context,
    KycCardholderResponse? cardholder,
  ) {
    final appCubit = context.read<AppCubit>();
    final user = appCubit.state.user;
    if (user == null) return;

    final providerTier = int.tryParse(cardholder?.providerTier ?? '') ?? 1;

    appCubit.updateUser(
      user.copyWith(
        isKycVerified: true,
        userTier: providerTier >= 2 ? 'two' : user.userTier,
      ),
    );
  }

  // The direct registerCardholder() response above is optimistic — Payscribe
  // can also activate KYC asynchronously after the fact, which only reaches
  // us via a webhook that updates the backend User record with no request
  // to hang a client update off. /kyc/status/ now returns the authoritative
  // is_kyc_verified/user_tier, so syncing here on every fetch/refresh of
  // this screen closes that gap.
  void _syncUserFromKycStatus(BuildContext context, KycStatus? kycStatus) {
    if (kycStatus == null) return;

    final appCubit = context.read<AppCubit>();
    final user = appCubit.state.user;
    if (user == null) return;

    if (user.isKycVerified == kycStatus.isKycVerified &&
        user.userTier == kycStatus.userTier) {
      return;
    }

    appCubit.updateUser(
      user.copyWith(
        isKycVerified: kycStatus.isKycVerified,
        userTier: kycStatus.userTier,
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
              onPressed: () => context
                  .read<KycStatusCubit>()
                  .registerCardholder(() => context.pop(true)),
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
