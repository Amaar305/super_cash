import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class DirectAirtimeGiveawayPage extends StatelessWidget {
  const DirectAirtimeGiveawayPage({super.key, required this.giveawayTypeId});
  final String giveawayTypeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DirectAirtimeGiveawayCubit(
        addDirectAirtimePhoneGiveawayUseCase: serviceLocator(),
        claimDirectAirtimeGiveawayUseCase: serviceLocator(),
        getDirectAirtimesGiveawayUseCase: serviceLocator(),
        giveawayTypeid: giveawayTypeId,
      ),
      child: DirectAirtimeGiveawayView(),
    );
  }
}

class DirectAirtimeGiveawayView extends StatelessWidget {
  const DirectAirtimeGiveawayView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: AppAppBarTitle('Direct Airtime Giveaway')),
      body: RefreshIndicator.adaptive(
        onRefresh: context.read<DirectAirtimeGiveawayCubit>().getAirtimes,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xlg,
          ),
          child:
              BlocListener<
                DirectAirtimeGiveawayCubit,
                DirectAirtimeGiveawayState
              >(
                listenWhen: (p, c) => p.status != c.status,
                listener: (context, state) {
                  if (state.status.isLoading) {
                    showLoadingOverlay(context);
                  } else {
                    hideLoadingOverlay();
                  }
                  if (state.status.isFailure && state.message.isNotEmpty) {
                    openSnackbar(SnackbarMessage.error(title: state.message));
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap.v(AppSpacing.xlg),
                    DirectAirtimeNetworkFilter(),
                    const Gap.v(AppSpacing.xlg),
                    Text(
                      'Available Giveaway',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF16233C),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap.v(AppSpacing.lg),
                    DirectAirtimeGiveawayListView(),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
