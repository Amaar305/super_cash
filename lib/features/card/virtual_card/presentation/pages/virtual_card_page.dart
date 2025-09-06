import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../cubit/virtual_card_cubit.dart';
import '../widgets/widgets.dart';

class VirtualCardPage extends StatelessWidget {
  const VirtualCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VirtualCardCubit(fetchVirtualCardUseCase: serviceLocator()),
      child: VirtualCardView(),
    );
  }
}

class VirtualCardView extends StatefulWidget {
  const VirtualCardView({super.key});

  @override
  State<VirtualCardView> createState() => _VirtualCardViewState();
}

class _VirtualCardViewState extends State<VirtualCardView> {
  @override
  void initState() {
    super.initState();
    context.read<VirtualCardCubit>().fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: AppLeadingAppBarWidget(onTap: context.pop),
        title: AppAppBarTitle(AppStrings.virtualCard),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<VirtualCardCubit>().fetchCards();
        },
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: VirtualCardListView(),
        ),
      ),
    );
  }
}
