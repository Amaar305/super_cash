import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/kyc/kyc_bvn/cubit/kyc_bvn_cubit.dart';
import 'package:super_cash/features/kyc/kyc_bvn/widgets/widgets.dart';

class KYCBvnPage extends StatelessWidget {
  const KYCBvnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KycBvnCubit(
        submitBvnUseCase: serviceLocator(),
        getBvnUseCase: serviceLocator(),
      )..getBvn(),
      child: const KYCBvnView(),
    );
  }
}

class KYCBvnView extends StatelessWidget {
  const KYCBvnView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<KycBvnCubit, KycBvnState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status.isSubmitted) {
          openSnackbar(
            SnackbarMessage.success(
              title: state.message.isNotEmpty
                  ? state.message
                  : 'BVN linked successfully.',
            ),
          );
          context.pop();
        }
        if (state.status.isFailure) {
          openSnackbar(SnackbarMessage.error(title: state.message));
        }
      },
      child: AppScaffold(
        appBar: AppBar(title: const AppAppBarTitle('BVN')),
        body: BlocBuilder<KycBvnCubit, KycBvnState>(
          buildWhen: (prev, curr) =>
              prev.status != curr.status &&
              (curr.status.isLoading ||
                  curr.status.isInitial ||
                  curr.status.isSuccess ||
                  (curr.status.isFailure && prev.bvnResponse == null)),
          builder: (context, state) {
            if (state.status.isInitial || state.status.isLoading) {
              return const Center(child: ThineCircularProgress());
            }
            if (state.status.isFailure && state.bvnResponse == null) {
              return _ErrorBody(message: state.message);
            }
            return const _FormBody();
          },
        ),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  const _FormBody();

  @override
  Widget build(BuildContext context) {
    final alreadySubmitted =
        context.select((KycBvnCubit c) => c.state.alreadySubmitted);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xlg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xlg,
        children: [
          _BvnInstructions(alreadySubmitted: alreadySubmitted),
          if (alreadySubmitted) _SubmittedBadge(),
          const KycBvnField(),
          const SizedBox(),
          const KycBvnSubmitButton(),
        ],
      ),
    );
  }
}

class _BvnInstructions extends StatelessWidget {
  const _BvnInstructions({required this.alreadySubmitted});

  final bool alreadySubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          alreadySubmitted ? 'Update your BVN' : 'Link your BVN',
          style: TextStyle(
            fontSize: 16,
            fontWeight: AppFontWeight.semiBold,
            color: context.adaptiveColor,
          ),
        ),
        Text(
          'Your Bank Verification Number (BVN) is an 11-digit number '
          'issued by the CBN to uniquely identify you across all banks.',
          style: TextStyle(
            fontSize: 14,
            color: context.adaptiveColor.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}

class _SubmittedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A7C4E).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.xs,
        children: const [
          Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF1A7C4E)),
          Text(
            'BVN already linked — you can update it below.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF1A7C4E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message});

  final String message;

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
              message.isNotEmpty ? message : 'Failed to load BVN status.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: context.adaptiveColor.withValues(alpha: 0.6),
              ),
            ),
            const Gap.v(AppSpacing.lg),
            TextButton(
              onPressed: () => context.read<KycBvnCubit>().getBvn(),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
