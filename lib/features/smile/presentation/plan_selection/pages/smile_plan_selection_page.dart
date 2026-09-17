import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/widgets.dart';
import 'package:super_cash/features/smile/presentation/plan_selection/plan_selection.dart';

/// Step 1: pick which Smile Data plan to buy.
class SmilePlanSelectionPage extends StatelessWidget {
  const SmilePlanSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SmilePlanSelectionCubit(fetchSmilePlansUseCase: serviceLocator()),
      child: const SmilePlanSelectionView(),
    );
  }
}

class SmilePlanSelectionView extends StatefulWidget {
  const SmilePlanSelectionView({super.key});

  @override
  State<SmilePlanSelectionView> createState() => _SmilePlanSelectionViewState();
}

class _SmilePlanSelectionViewState extends State<SmilePlanSelectionView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<SmilePlanSelectionCubit>().fetchPlans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.smile),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.smileVoiceAndDataBundles,
              style: const TextStyle(fontWeight: AppFontWeight.semiBold),
            ),
            const Gap.v(AppSpacing.md),
            const _SmilePlanSearchField(),
            const Gap.v(AppSpacing.md),
            const Expanded(child: _SmilePlanList()),
          ],
        ),
      ),
    );
  }
}

class _SmilePlanSearchField extends StatelessWidget {
  const _SmilePlanSearchField();

  @override
  Widget build(BuildContext context) {
    return AppTextField.underlineBorder(
      hintText: 'Search plans',
      prefixIcon: const Icon(Icons.search, size: 22, color: AppColors.grey),
      onChanged: (query) =>
          context.read<SmilePlanSelectionCubit>().onSearchChanged(query),
    );
  }
}

class _SmilePlanList extends StatelessWidget {
  const _SmilePlanList();

  @override
  Widget build(BuildContext context) {
    final status = context.select(
      (SmilePlanSelectionCubit c) => c.state.status,
    );
    final message = context.select(
      (SmilePlanSelectionCubit c) => c.state.message,
    );
    final plans = context.select(
      (SmilePlanSelectionCubit c) => c.state.visiblePlans,
    );

    if (status.isLoading) return const Loader();

    if (status.isError) {
      return AppEmptyState(
        title: 'Unable to load plans',
        description: message,
        icon: Icons.wifi_off_rounded,
        action: PrimaryButton(
          label: 'Try again',
          onPressed: () => context.read<SmilePlanSelectionCubit>().fetchPlans(),
        ),
      );
    }

    if (plans.isEmpty) {
      return const AppEmptyState(
        title: 'No plans found',
        description: 'Try a different search term.',
        icon: Icons.search_off_rounded,
      );
    }

    return ListView.separated(
      itemCount: plans.length,
      separatorBuilder: (_, __) => const Gap.v(AppSpacing.sm),
      itemBuilder: (context, index) {
        final plan = plans[index];
        return SmilePlanTile(
          plan: plan,
          onTap: () => context.push<void>(AppRoutes.smilePurchase, extra: plan),
        );
      },
    );
  }
}
