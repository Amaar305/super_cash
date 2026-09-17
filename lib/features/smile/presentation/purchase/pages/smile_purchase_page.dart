import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/smile/domain/domain.dart';
import 'package:super_cash/features/smile/presentation/purchase/purchase.dart';

/// Step 2: verify the Smile email, pick an account and buy the plan chosen
/// on the previous page.
class SmilePurchasePage extends StatelessWidget {
  const SmilePurchasePage({super.key, required this.plan});

  final SmilePlan plan;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SmilePurchaseCubit(
        plan: plan,
        verifySmileEmailUseCase: serviceLocator(),
        purchaseSmilePlanUseCase: serviceLocator(),
        queryTransactionStatusUseCase: serviceLocator(),
      ),
      child: const SmilePurchaseView(),
    );
  }
}

class SmilePurchaseView extends StatelessWidget {
  const SmilePurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.smile),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.lg,
        ).copyWith(bottom: AppSpacing.xxlg),
        child: const SmilePurchaseButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: const [SmilePurchaseForm(), Gap.v(AppSpacing.xlg)],
      ),
    );
  }
}
