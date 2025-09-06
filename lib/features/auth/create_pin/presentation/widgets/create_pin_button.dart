import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../auth.dart';

class CreatePinButton extends StatelessWidget {
  const CreatePinButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((CreatePinCubit cubit) => cubit.state.status.isLoading);
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.submit,
      onPressed: () => context.read<CreatePinCubit>().onSubmit(),
    );
  }
}
