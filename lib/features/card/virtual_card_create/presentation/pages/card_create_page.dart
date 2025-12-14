import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/card/card.dart';



class CardCreatePage extends StatelessWidget {
  const CardCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateVirtualCardCubit(createCardUseCases: serviceLocator()),
      child: CardCreateView(),
    );
  }
}

class CardCreateView extends StatelessWidget {
  const CardCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: AppLeadingAppBarWidget(onTap: context.pop),
        title: AppAppBarTitle(AppStrings.virtualCard),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.md + 2,
            children: [
              CreateVirtualCardTypeTab(),
              CardBrandSection(),
              CardCreateSamplesSection(),
              // Center(child: CardDollarRateWidget()),
              NewWidget(),

              CardCreationFeeWidget(),
              Gap.v(AppSpacing.sm),

              CardFeaturesSection(),
              Gap.v(AppSpacing.sm),
              CardSupportedPlatforms(),
              CardCreateProceedButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({super.key});

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  bool _expanded = false;

  void setExpanded(bool expand) {
    setState(() {
      _expanded = expand;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = _expanded
        ? AppColors.blue
        : AppColors.blue.withValues(alpha: 0.097);
    final isPlatinum = context.select(
      (CreateVirtualCardCubit element) => element.state.platinum,
    );
    return Tappable.faded(
      onTap: () => setExpanded(!_expanded),
      child: AnimatedContainer(
        duration: 200.ms,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.md + 2,
          horizontal: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.sm - 1),
          border: Border.all(color: color),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardCollapsableTile(
                title: AppStrings.cardTermsOfUsage,
                onTap: () => setExpanded(!_expanded),
                leading: Icon(Icons.data_usage_outlined, color: AppColors.blue),
                trailing: CardDropIconButton(
                  isExpanded: _expanded,
                  onTap: () => setExpanded(!_expanded),
                ),
              ),
              if (_expanded) ...[
                Gap.v(AppSpacing.lg),
                CardTermsOfUsageSection(isPlatinum: isPlatinum),
                Gap.v(AppSpacing.lg),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CardCreateProceedButton extends StatelessWidget {
  const CardCreateProceedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: AppStrings.proceed,
      onPressed: () {
        Navigator.push(
          context,
          CardCreatePinPage.route(
            cardCubit: context.read<CreateVirtualCardCubit>(),
          ),
        );
      },
    );
  }
}

class CreateVirtualCardTypeTab extends StatelessWidget {
  const CreateVirtualCardTypeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isUSDCard = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.isUSDCard,
    );
    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.cardType,
          style: TextStyle(
            fontSize: AppSpacing.md - 1,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        VirtualCardTypeTab(
          isUSD: isUSDCard,
          onChanged: context.read<CreateVirtualCardCubit>().updateCardType,
        ),
      ],
    );
  }
}
