import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/kyc/kyc_government_id/cubit/kyc_government_id_cubit.dart';

class KycGovIdImagePreview extends StatelessWidget {
  const KycGovIdImagePreview({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imageFile = context.select(
      (KycGovernmentIdCubit c) => c.state.documentImageFile,
    );
    final imageUrl = context.select(
      (KycGovernmentIdCubit c) => c.state.displayImageUrl,
    );
    final imageError = context.select(
      (KycGovernmentIdCubit c) => c.state.documentImageError,
    );
    final isUploading = context.select(
      (KycGovernmentIdCubit c) => c.state.status.isUploading,
    );

    final hasError = imageError != null && imageError.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Tappable.faded(
          throttle: true,
          throttleDuration: const Duration(milliseconds: 300),
          onTap: isUploading ? null : onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.isLight
                  ? const Color(0xFFF0F4FF)
                  : const Color(0xFF1A1A2E),
            ),
            child: DottedBorder(
              dashPattern: const [10, 5],
              radius: const Radius.circular(6),
              color: hasError ? AppColors.red : AppColors.grey,
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Center(
                child: _PreviewContent(
                  imageFile: imageFile,
                  imageUrl: imageUrl,
                ),
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const Gap.v(AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Text(
              imageError,
              style: const TextStyle(fontSize: 12, color: AppColors.red),
            ),
          ),
        ],
      ],
    );
  }
}

class _PreviewContent extends StatelessWidget {
  const _PreviewContent({this.imageFile, this.imageUrl});

  final File? imageFile;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageFile != null) {
      return SizedBox(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.file(
            imageFile!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      );
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return SizedBox(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (_, __, ___) => const _EmptyPlaceholder(),
          ),
        ),
      );
    }

    return const _EmptyPlaceholder();
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  const _EmptyPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xlg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.md,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: context.adaptiveColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.credit_card_outlined,
              size: 22,
              color: context.adaptiveColor.withValues(alpha: 0.5),
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Tap to upload ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: AppFontWeight.medium,
                color: context.adaptiveColor,
              ),
              children: [
                TextSpan(
                  text: 'your ID image',
                  style: TextStyle(fontWeight: AppFontWeight.regular),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Max file size: 0.8 MB',
            style: TextStyle(
              fontSize: 13,
              color: context.adaptiveColor.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
