import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation.dart';

class CableCardProviderField extends StatefulWidget {
  const CableCardProviderField({super.key});

  @override
  State<CableCardProviderField> createState() => _CableCardProviderFieldState();
}

class _CableCardProviderFieldState extends State<CableCardProviderField> {
  late final CableCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CableCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (CableCubit cubit) => cubit.state.status.isLoading,
    );
    final plans = context.select(
      (CableCubit cubit) => cubit.state.plans?['plans'],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(AppStrings.cableProvider, style: context.bodySmall),
        CardProviderContainer(
          onTap: isLoading || plans == null
              ? _showErrorMsgDialog
              : () => _showCablePlansSheet(context, plans),
        ),
      ],
    );
  }

  void _showCablePlansSheet(BuildContext context, List plans) {
    context.showExtraBottomSheet(
      title: 'Select Cable Provider',
      children: plans
          .map(
            (plan) => CablePlanTile(
              plan: plan,
              onTap: () {
                _cubit.onPlanSection(plan);
                context.pop();
                // Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          )
          .toList(),
    );
  }

  void _showErrorMsgDialog() {
    return openSnackbar(
      SnackbarMessage.error(title: 'Please select a cable provider.'),
      clearIfQueue: true,
    );
  }
}

class CardProviderContainer extends StatelessWidget {
  const CardProviderContainer({super.key, this.child, this.onTap});

  final Widget? child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final plan = context.select((CableCubit element) => element.state.plan);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.darkGrey, width: 0.2),
        ),
      ),
      child: Tappable(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                plan == null ? 'Select plans' : plan['name'],
                style: TextStyle(
                  color: plan == null
                      ? AppColors.hinTextColor
                      : AppColors.black,
                  fontSize: AppSpacing.lg,
                  fontWeight: AppFontWeight.light,
                ),
              ),
            ),
            Icon(Icons.select_all, color: AppColors.grey, size: AppSpacing.xlg),
          ],
        ),
      ),
    );
  }
}
