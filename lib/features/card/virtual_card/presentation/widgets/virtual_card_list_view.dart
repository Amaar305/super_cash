import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/card/virtual_card/virtual_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VirtualCardListView extends StatelessWidget {
  const VirtualCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = context.select((VirtualCardCubit cubit) => cubit.state.cards);
    final isLoading = context.select(
      (VirtualCardCubit cubit) => cubit.state.status.isLaoding,
    );

    if (cards.isEmpty && isLoading) {
      return Center(
        child: CircularProgressIndicator.adaptive(strokeWidth: AppSpacing.xxs),
      );
    } else if (cards.isEmpty) {
      return NoCreditCardWidget();
    }

    return BlocListener<VirtualCardCubit, VirtualCardState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
        if (state.status.isLaoding) {
          openSnackbar(
            SnackbarMessage.loading(title: 'loading..'),
            clearIfQueue: true,
          );
        }
      },
      child: Column(
        spacing: AppSpacing.md,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: VirtualCardTypeTab(),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];

                return VirtualCardWidget(card: card);
              },
            ),
          ),
          VirtualCardCreateButton(
            onTap: () => context.goNamedSafe(RNames.virtualCardCreate),
            label: AppStrings.createNewVirtualCard,
          ),
        ],
      ),
    );
  }
}
