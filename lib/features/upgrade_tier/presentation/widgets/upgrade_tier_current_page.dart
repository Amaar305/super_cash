import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpgradeTierCurrentPage extends StatelessWidget {
  const UpgradeTierCurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = context.select(
      (UpgradeTierCubit cubit) => cubit.state.currentStep,
    );
    final page = switch (currentStep) {
      1 => VerifyRegisteredDetailsPage(key: ValueKey(1)),
      2 => AddressVerificationPage(key: ValueKey(2)),
      _ => SubmitKycDocumentPage(key: ValueKey(3)),
    };
    return BlocListener<UpgradeTierCubit, UpgradeTierState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
        if (state.status.isUpgraded) {
          openSnackbar(
            SnackbarMessage.success(title: "Successfully migrated to tier two"),
            clearIfQueue: true,
          );
        }
      },
      child: page,
    );
  }
}
