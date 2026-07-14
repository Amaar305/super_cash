import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/kyc/kyc_selfie/cubit/kyc_selfie_cubit.dart';

class KycSelfiePickerButtons extends StatelessWidget {
  const KycSelfiePickerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isUploading = context.select(
      (KycSelfieCubit c) => c.state.status.isUploading,
    );
    return Row(
      children: [
        Expanded(
          child: _PickerButton(
            icon: Icons.camera_alt_outlined,
            label: 'Camera',
            onTap: isUploading ? null : () => _pick(context, fromCamera: true),
          ),
        ),
        const Gap.h(AppSpacing.md),
        Expanded(
          child: _PickerButton(
            icon: Icons.photo_library_outlined,
            label: 'Gallery',
            onTap: isUploading ? null : () => _pick(context, fromCamera: false),
          ),
        ),
      ],
    );
  }

  Future<void> _pick(BuildContext context, {required bool fromCamera}) async {
    try {
      final result = await MediaPickerHelper.pickMedia(
        mediaType: fromCamera ? MediaType.camera : MediaType.image,
      );
      if (context.mounted) {
        context.read<KycSelfieCubit>().onSelfieSelected(result?.file);
      }
    } catch (error, stackTrace) {
      logE('Error picking selfie: $error', stackTrace: stackTrace);
    }
  }
}

class _PickerButton extends StatelessWidget {
  const _PickerButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = context.isLight
        ? const Color(0xFFF3F4F6)
        : const Color(0xFF1C1C1C);

    return Tappable.scaled(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.xs,
          children: [
            Icon(icon, size: 20, color: context.adaptiveColor.withValues(alpha: 0.6)),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: AppFontWeight.medium,
                color: context.adaptiveColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
