import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class AddProductAddressForm extends StatelessWidget {
  const AddProductAddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductGiveawayCubit, ProductGiveawayState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailed && state.message.isNotEmpty) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.lg,

        children: [
          ProductAddressFullNameField(),
          ProductAddressPhoneNumberField(),
          ProductAddressStateField(),
          ProductAddressHomeAddressField(),
        ],
      ),
    );
  }
}
