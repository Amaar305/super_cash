import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/cubit/kyc_personal_information_cubit.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/widgets/widgets.dart';

class KycPersonalInformationPage extends StatelessWidget {
  const KycPersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KycPersonalInformationCubit(
        getPersonalInfoUseCase: serviceLocator(),
        submitPersonalInfoUseCase: serviceLocator(),
        appCubit: serviceLocator(),
      )..getPersonalInfo(),
      child: const KycPersonalInformationView(),
    );
  }
}

class KycPersonalInformationView extends StatelessWidget {
  const KycPersonalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<KycPersonalInformationCubit, KycPersonalInformationState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status.isSubmitted) {
          openSnackbar(
            SnackbarMessage.success(
              title: state.message.isNotEmpty
                  ? state.message
                  : 'Personal info saved.',
            ),
          );
          context.pop();
        }
        if (state.status.isFailure) {
          openSnackbar(SnackbarMessage.error(title: state.message));
        }
      },
      child: AppScaffold(
        appBar: AppBar(title: const AppAppBarTitle('Personal Info.')),
        body: BlocBuilder<KycPersonalInformationCubit, KycPersonalInformationState>(
          buildWhen: (prev, curr) =>
              prev.status != curr.status &&
              (curr.status.isLoading || curr.status.isInitial || curr.status.isSuccess ||
                  (curr.status.isFailure && prev.personalInfoResponse == null)),
          builder: (context, state) {
            if (state.status.isInitial || state.status.isLoading) {
              return const Center(child: ThineCircularProgress());
            }
            if (state.status.isFailure && state.personalInfoResponse == null) {
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xlg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xlg,
        children: const [
          KycPersonalInfoForm(),
          SizedBox(),
          KycPersonalInfoSubmitButton(),
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
              message.isNotEmpty ? message : 'Failed to load personal info.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: context.adaptiveColor.withValues(alpha: 0.6),
              ),
            ),
            const Gap.v(AppSpacing.lg),
            TextButton(
              onPressed: () =>
                  context.read<KycPersonalInformationCubit>().getPersonalInfo(),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
