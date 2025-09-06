import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/presentation/widgets/save_beneficiary_name_field.dart';
import 'package:super_cash/features/vtupass/manage_beneficiary/presentation/widgets/save_beneficiary_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/save_update_beneficiary_cubit.dart';

class SaveBeneficiaryForm extends StatelessWidget {
  const SaveBeneficiaryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveUpdateBeneficiaryCubit, SaveUpdateBeneficiaryState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure && state.message.isNotEmpty) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
          return;
        }
        if (state.status.isSuccess) {
          openSnackbar(
            SnackbarMessage.success(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(
        spacing: AppSpacing.xlg,
        children: [SaveBeneficiaryNameField(), SaveBeneficiaryPhoneField()],
      ),
    );
  }
}
