import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth.dart';

class CreatePinAssistanceButton extends StatelessWidget {
  const CreatePinAssistanceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((CreatePinCubit cubit) => cubit.state.status.isLoading);
    return AssistanceButton(isLoading: isLoading);
  }
}
