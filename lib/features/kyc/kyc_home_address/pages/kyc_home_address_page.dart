import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/kyc/kyc_home_address/cubit/kyc_home_address_cubit.dart';
import 'package:super_cash/features/kyc/kyc_home_address/widgets/widgets.dart';

class KycHomeAddressPage extends StatelessWidget {
  const KycHomeAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KycHomeAddressCubit(
        getAddressUseCase: serviceLocator(),
        submitAddressUseCase: serviceLocator(),
      )..getAddress(),
      child: const KycHomeAddressView(),
    );
  }
}

class KycHomeAddressView extends StatelessWidget {
  const KycHomeAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<KycHomeAddressCubit, KycHomeAddressState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status.isSubmitted) {
          openSnackbar(
            SnackbarMessage.success(
              title: state.message.isNotEmpty
                  ? state.message
                  : 'Address saved.',
            ),
          );
          context.pop();
        }
        if (state.status.isFailure) {
          openSnackbar(SnackbarMessage.error(title: state.message));
        }
      },
      child: AppScaffold(
        appBar: AppBar(title: const AppAppBarTitle('Home Address')),
        body: BlocBuilder<KycHomeAddressCubit, KycHomeAddressState>(
          buildWhen: (prev, curr) =>
              prev.status != curr.status &&
              (curr.status.isLoading ||
                  curr.status.isInitial ||
                  curr.status.isSuccess ||
                  (curr.status.isFailure && prev.addressData == null)),
          builder: (context, state) {
            if (state.status.isInitial || state.status.isLoading) {
              return const Center(child: ThineCircularProgress());
            }
            if (state.status.isFailure && state.addressData == null) {
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
          KycHomeAddressForm(),
          SizedBox(),
          KycHomeAddressSubmitButton(),
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
              message.isNotEmpty ? message : 'Failed to load address.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: context.adaptiveColor.withValues(alpha: 0.6),
              ),
            ),
            const Gap.v(AppSpacing.lg),
            TextButton(
              onPressed: () =>
                  context.read<KycHomeAddressCubit>().getAddress(),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
