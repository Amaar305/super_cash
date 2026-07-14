import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/widgets/field_label_title.dart';
import 'package:super_cash/features/kyc/kyc_personal_information/cubit/kyc_personal_information_cubit.dart';

class KycPersonalInfoDobField extends StatelessWidget {
  const KycPersonalInfoDobField({super.key});

  @override
  Widget build(BuildContext context) {
    final dob = context.select(
      (KycPersonalInformationCubit c) => c.state.dateOfBirth,
    );
    final error = context.select(
      (KycPersonalInformationCubit c) => c.state.dateOfBirthError,
    );

    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabelTitle('Date of Birth'),
        _DobTapTarget(dob: dob, error: error),
      ],
    );
  }
}

class _DobTapTarget extends StatelessWidget {
  const _DobTapTarget({required this.dob, required this.error});

  final String dob;
  final String? error;

  String get _displayText =>
      dob.isNotEmpty ? _format(dob) : 'Select date of birth';

  bool get _hasValue => dob.isNotEmpty;

  String _format(String raw) {
    // raw is yyyy-MM-dd from backend / picker
    final parts = raw.split('-');
    if (parts.length != 3) return raw;
    return '${parts[2]}/${parts[1]}/${parts[0]}';
  }

  Future<void> _pickDate(BuildContext context) async {
    final cubit = context.read<KycPersonalInformationCubit>();
    final now = DateTime.now();
    final minYear = DateTime(now.year - 100);
    final maxYear = DateTime(now.year - 18);

    DateTime initial = maxYear;
    if (cubit.state.dateOfBirth.isNotEmpty) {
      final parts = cubit.state.dateOfBirth.split('-');
      if (parts.length == 3) {
        initial = DateTime(
          int.tryParse(parts[0]) ?? maxYear.year,
          int.tryParse(parts[1]) ?? 1,
          int.tryParse(parts[2]) ?? 1,
        );
      }
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: minYear,
      lastDate: maxYear,
      helpText: 'SELECT DATE OF BIRTH',
    );

    if (picked != null) {
      cubit.onDateOfBirthSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Tappable.scaled(
          onTap: () => _pickDate(context),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md + 2,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: error != null
                      ? AppColors.red
                      : context.adaptiveColor.withValues(alpha: 0.2),
                  width: error != null ? 2 : 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: AppColors.grey,
                ),
                const Gap.h(AppSpacing.sm),
                Text(
                  _displayText,
                  style: TextStyle(
                    fontSize: 14,
                    color: _hasValue
                        ? context.adaptiveColor
                        : AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (error != null) ...[
          const Gap.v(AppSpacing.xs),
          Text(
            error!,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.red,
            ),
          ),
        ],
      ],
    );
  }
}
