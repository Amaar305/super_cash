import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation.dart';

class FreezeCardTileWidget extends StatefulWidget {
  const FreezeCardTileWidget({super.key, required this.cardId});

  final String cardId;

  @override
  State<FreezeCardTileWidget> createState() => _FreezeCardTileWidgetState();
}

class _FreezeCardTileWidgetState extends State<FreezeCardTileWidget> {
  late final CardDetailCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = context.read<CardDetailCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CardDetailCubit cubit) => cubit.state.status.isLoading,
    );
    final cardStatus = context.select(
      (CardDetailCubit cubit) => cubit.state.cardDetails?.isActive ?? false,
    );

    return CardQuickActionTile(
      leading: Assets.icons.iconWallet.svg(),
      title: AppStrings.freezCard,
      onTap: isLoading ? null : () => onCardFreezed(cardStatus),
    );
  }

  void onCardFreezed(bool cardStatus) {
    context.showExtraBottomSheet(
      title: AppStrings.freezCard,
      description: cardStatus
          ? AppStrings.freezCardDescription
          : AppStrings.unfreezeCardDescription,
      icon: Assets.images.warning.image(),
      children: [
        BlocProvider.value(
          value: _cubit,
          child: FreezeCardBottomSheetButton(cardId: widget.cardId),
        ),
        Row(
          children: [
            Expanded(
              child: AppOutlinedButton(
                isLoading: false,
                label: AppStrings.cancel,
                onPressed: context.pop,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FreezeCardBottomSheetButton extends StatelessWidget {
  const FreezeCardBottomSheetButton({super.key, required this.cardId});
  final String cardId;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CardDetailCubit cubit) => cubit.state.status.isLoading,
    );
    final cardStatus = context.select(
      (CardDetailCubit cubit) => cubit.state.cardDetails?.isActive ?? false,
    );

    return PrimaryButton(
      label: AppStrings.yesContinue,
      isLoading: isLoading,
      onPressed: () {
        context.read<CardDetailCubit>().onFreezeCard(
          onFreezed: (message) {
            context.showConfirmationBottomSheet(
              title: cardStatus ? AppStrings.freezCard : AppStrings.unFreezCard,
              okText: AppStrings.done,
              description: message,
            );
          },
        );
      },
    );
  }
}
