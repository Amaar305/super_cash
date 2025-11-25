import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';

class BonusPage extends StatelessWidget {
  const BonusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BonusCubit(
        bankListUseCase: serviceLocator(),
        sendMoneyUseCase: serviceLocator(),
        validateBankUseCase: serviceLocator(),
        withdrawBonusUseCase: serviceLocator(),
      ),
      child: BonusView(),
    );
  }
}

class BonusView extends StatefulWidget {
  const BonusView({super.key});

  @override
  State<BonusView> createState() => _BonusViewState();
}

class _BonusViewState extends State<BonusView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BonusCubit>().fetchBankList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: AppAppBarTitle('Bonus'),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
        actions: [
          BlocSelector<BonusCubit, BonusState, bool>(
            selector: (state) => state.status.isValidated,
            builder: (context, isValidated) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isValidated
                    ? TextButton.icon(
                        label: Text('Reset State'),
                        icon: Icon(Icons.skip_previous_outlined),
                        onPressed: () => context.read<BonusCubit>()
                          ..resetState()
                          ..fetchBankList(),
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),

      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),

        child: Column(
          spacing: AppSpacing.lg,
          children: [
            BonusTabType(),
            BonusTitle(),
            EarningBonusWidget(),
            BonusContent(),
          ],
        ),
      ),
    );
  }
}

class EarningBonusWidget extends StatelessWidget {
  const EarningBonusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bonus = context.select(
      (AppCubit element) => element.state.user?.wallet.bonus ?? '0',
    );
    return EarningContainerInfo('Bonus Balance: N$bonus');
  }
}
