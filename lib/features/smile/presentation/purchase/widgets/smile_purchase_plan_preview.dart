import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/widgets/widgets.dart';
import 'package:super_cash/features/smile/presentation/purchase/purchase.dart';

/// Read-only preview of the plan chosen on the previous page.
class SmilePurchasePlanPreview extends StatelessWidget {
  const SmilePurchasePlanPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final plan = context.select((SmilePurchaseCubit c) => c.state.plan);
    final total = plan.total;
    final amount = total == total.roundToDouble()
        ? total.toStringAsFixed(0)
        : total.toStringAsFixed(2);

    return ValidationSummaryContainer(
      child: Row(
        spacing: AppSpacing.md,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: Assets.images.smile.image().image,
          ),
          Expanded(
            child: Text(
              plan.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(fontWeight: AppFontWeight.medium),
            ),
          ),
          Text(
            '₦$amount',
            style: const TextStyle(
              fontWeight: AppFontWeight.bold,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
