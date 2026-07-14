import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/features/kyc/kyc_selfie/cubit/kyc_selfie_cubit.dart';

class KycSelfiePreview extends StatelessWidget {
  const KycSelfiePreview({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final selfieFile = context.select((KycSelfieCubit c) => c.state.selfieFile);
    final imagerl = context.select(
      (KycSelfieCubit c) => c.state.displayImageUrl,
    );
    // TODO: Remove here in production
    final imageUrl = imagerl?.replaceAll(
      'https://supercash.com.ng',
      'http://127.0.0.1:8000',
    );
    final selfieError = context.select(
      (KycSelfieCubit c) => c.state.selfieError,
    );
    final isUploading = context.select(
      (KycSelfieCubit c) => c.state.status.isUploading,
    );

    final hasError = selfieError != null && selfieError.isNotEmpty;

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
                  selfieFile: selfieFile,
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
              selfieError,
              style: const TextStyle(fontSize: 12, color: AppColors.red),
            ),
          ),
        ],
      ],
    );
  }
}

class _PreviewContent extends StatelessWidget {
  const _PreviewContent({this.selfieFile, this.imageUrl});

  final File? selfieFile;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    print('imageUrl: $imageUrl');
    if (selfieFile != null) {
      return SizedBox(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.file(
            selfieFile!,
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
              Icons.camera_alt_outlined,
              size: 22,
              color: context.adaptiveColor.withValues(alpha: 0.5),
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Tap to take or upload ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: AppFontWeight.medium,
                color: context.adaptiveColor,
              ),
              children: [
                TextSpan(
                  text: 'a selfie',
                  style: TextStyle(fontWeight: AppFontWeight.regular),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Max file size: 0.5 MB',
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
