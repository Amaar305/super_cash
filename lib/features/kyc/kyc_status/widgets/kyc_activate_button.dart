import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/kyc/kyc_status/cubit/kyc_status_cubit.dart';

class KycActivateButton extends StatelessWidget {
  const KycActivateButton({
    super.key,
    required this.canActivate,
    required this.completedCount,
    required this.totalSteps,
    required this.onPressed,
  });

  final bool canActivate;
  final int completedCount;
  final int totalSteps;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isRegistering = context.select(
      (KycStatusCubit c) => c.state.status.isRegistering,
    );
    final active = canActivate && !isRegistering;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: active ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: active
                  ? AppColors.primary2
                  : (context.isLight
                        ? const Color(0xFFE5E7EB)
                        : const Color(0xFF2A2A2A)),
              disabledBackgroundColor: context.isLight
                  ? const Color(0xFFE5E7EB)
                  : const Color(0xFF2A2A2A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: isRegistering
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.adaptiveColor.withValues(alpha: 0.5),
                    ),
                  )
                : Text(
                    'Upgrade tier 2',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: AppFontWeight.semiBold,
                      color: active
                          ? AppColors.white
                          : context.adaptiveColor.withValues(alpha: 0.35),
                    ),
                  ),
          ),
        ),
        if (!canActivate) ...[
          const Gap.v(AppSpacing.xs),
          Text(
            'Complete $totalSteps steps to proceed',
            style: TextStyle(
              fontSize: 12,
              color: context.adaptiveColor.withValues(alpha: 0.4),
            ),
          ),
        ],
      ],
    );
  }
}
