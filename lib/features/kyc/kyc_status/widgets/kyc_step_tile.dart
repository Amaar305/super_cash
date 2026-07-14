import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/features/kyc/kyc_status/cubit/kyc_status_cubit.dart';

class KycStepTile extends StatelessWidget {
  const KycStepTile({
    super.key,
    required this.item,
    required this.isLast,
    required this.onTap,
  });

  final KycStepItem item;
  final bool isLast;
  final VoidCallback onTap;

  static const Color green = AppColors.blue;
  static const Color lineColor = Color(0xFFDDE0E6);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TimelineColumn(
            number: item.number,
            complete: item.complete,
            isLast: isLast,
          ),
          const Gap.h(AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.sm),
              child: _StepCard(item: item, onTap: onTap),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineColumn extends StatelessWidget {
  const _TimelineColumn({
    required this.number,
    required this.complete,
    required this.isLast,
  });

  final int number;
  final bool complete;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StepCircle(number: number, complete: complete),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2,
              color: complete ? KycStepTile.green : KycStepTile.lineColor,
            ),
          ),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({required this.number, required this.complete});

  final int number;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    if (complete) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: KycStepTile.green,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 16),
      );
    }
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: KycStepTile.lineColor, width: 2),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 13,
            fontWeight: AppFontWeight.semiBold,
            color: context.adaptiveColor.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.item, required this.onTap});

  final KycStepItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = context.isLight
        ? const Color(0xFFF3F4F6)
        : const Color(0xFF1C1C1C);

    return Tappable.scaled(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: AppFontWeight.semiBold,
                          color: context.adaptiveColor,
                        ),
                      ),
                      if (item.hasMissingFields) ...[
                        const Gap.h(AppSpacing.xs),
                        _MissingFieldsBadge(),
                      ],
                      const Spacer(),
                      if (item.complete) ...[
                        const Text(
                          'COMPLETED',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: AppFontWeight.semiBold,
                            color: KycStepTile.green,
                            letterSpacing: 0.5,
                          ),
                        ),
                        if (KycFlags.allowKycEdit) ...[
                          const Gap.h(AppSpacing.xs),
                          const Icon(
                            Icons.edit_outlined,
                            size: 13,
                            color: KycStepTile.green,
                          ),
                        ],
                      ] else
                        Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: context.adaptiveColor.withValues(alpha: 0.4),
                        ),
                    ],
                  ),
                  const Gap.v(AppSpacing.xs),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.adaptiveColor.withValues(alpha: 0.55),
                      fontWeight: AppFontWeight.light,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MissingFieldsBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4E4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'MISSING FIELDS',
        style: TextStyle(
          fontSize: 10,
          fontWeight: AppFontWeight.semiBold,
          color: Color(0xFFD9534F),
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
