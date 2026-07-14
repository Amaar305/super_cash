import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/kyc/kyc_government_id/cubit/kyc_government_id_cubit.dart';
import 'package:super_cash/features/kyc/kyc_government_id/widgets/widgets.dart';

class KYCGovernmentIdPage extends StatelessWidget {
  const KYCGovernmentIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KycGovernmentIdCubit(
        getDocumentsUseCase: serviceLocator(),
        uploadDocumentsUseCase: serviceLocator(),
      )..getDocuments(),
      child: const KYCGovernmentIdView(),
    );
  }
}

class KYCGovernmentIdView extends StatelessWidget {
  const KYCGovernmentIdView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<KycGovernmentIdCubit, KycGovernmentIdState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status.isUploaded) {
          openSnackbar(
            SnackbarMessage.success(
              title: state.message.isNotEmpty
                  ? state.message
                  : 'Document uploaded successfully.',
            ),
          );
          context.pop();
        }
        if (state.status.isFailure) {
          openSnackbar(SnackbarMessage.error(title: state.message));
        }
      },
      child: AppScaffold(
        appBar: AppBar(title: const AppAppBarTitle('Government ID')),
        body: BlocBuilder<KycGovernmentIdCubit, KycGovernmentIdState>(
          buildWhen: (prev, curr) =>
              prev.status != curr.status &&
              (curr.status.isLoading ||
                  curr.status.isInitial ||
                  curr.status.isSuccess ||
                  (curr.status.isFailure &&
                      prev.documentsListResponse == null)),
          builder: (context, state) {
            if (state.status.isInitial || state.status.isLoading) {
              return const Center(child: ThineCircularProgress());
            }
            if (state.status.isFailure &&
                state.documentsListResponse == null) {
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

  void _showPickerSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<KycGovernmentIdCubit>(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xlg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.md,
            children: const [
              Text(
                'Choose an option',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              KycGovIdPickerButtons(),
            ],
          ),
        ),
      ),
    );
  }

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
        children: [
          KycGovIdForm(onImageTap: () => _showPickerSheet(context)),
          const SizedBox(),
          const KycGovIdSubmitButton(),
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
              message.isNotEmpty ? message : 'Failed to load documents.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: context.adaptiveColor.withValues(alpha: 0.6),
              ),
            ),
            const Gap.v(AppSpacing.lg),
            TextButton(
              onPressed: () =>
                  context.read<KycGovernmentIdCubit>().getDocuments(),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
