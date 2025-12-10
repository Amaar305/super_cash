import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CardCreateButton extends StatelessWidget {
  const CardCreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.status.isLoading,
    );
    final cubit = context.read<CreateVirtualCardCubit>();
    return PrimaryButton(
      isLoading: isLoading,
      label: AppStrings.createCard,
      onPressed: () async {
        final result = await context.push<bool?>(AppRoutes.confirmationDialog);

        if (result == true) {
          cubit.onSubmit(() {
            context.showConfirmationBottomSheet(
              title: 'Successfully Created',
              okText: AppStrings.done,
              description: 'Congratulations!. User Card has been created.',
              onDone: () {
                context
                  ..pop()
                  ..goNamed(RNames.dashboard);
              },
            );
          });
        }
      },
    );
  }
}
