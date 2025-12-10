import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/upgrade_tier/presentation/presentation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class SubmitKycSelfieWidget extends StatefulWidget {
  const SubmitKycSelfieWidget({super.key});

  @override
  State<SubmitKycSelfieWidget> createState() => _SubmitKycSelfieWidgetState();
}

class _SubmitKycSelfieWidgetState extends State<SubmitKycSelfieWidget> {
  late final UpgradeTierCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<UpgradeTierCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final isloading = context.select(
      (UpgradeTierCubit cubit) => cubit.state.status.isLoading,
    );
    final selfie = context.select(
      (UpgradeTierCubit cubit) => cubit.state.selfie,
    );
    final selfieErrMsg = context.select(
      (UpgradeTierCubit cubit) => cubit.state.selfieImageErrMsg,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        Text(
          AppStrings.selectImage,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        SubmitKycDottedContainer(
          enabled: !isloading,
          isError: selfieErrMsg != null && selfieErrMsg.isNotEmpty,
          selfie: selfie,
          onTap: _onSelfieTaked,
          child: Center(
            child: Column(
              spacing: AppSpacing.md,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                  child: Assets.icons.camera.svg(),
                ),
                Text.rich(
                  style: TextStyle(
                    fontSize: AppSpacing.md,
                    fontWeight: AppFontWeight.medium,
                  ),
                  TextSpan(
                    text: 'Click to Upload ',
                    children: [
                      TextSpan(
                        text: 'or take a selfie',
                        style: TextStyle(fontWeight: AppFontWeight.regular),
                      ),
                    ],
                  ),
                ),
                Text('(Max. File size: 25 MB)', style: context.bodySmall),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSelfieTaked() async {
    try {
      // TODO: Handle permission denied errors
      final result = await MediaPickerHelper.pickMedia(
        mediaType: MediaType.image,
      );
      _cubit.onSelfieTake(result?.file);
    } catch (e) {
      logE(e);
    }
  }
}

class SubmitKycDottedContainer extends StatelessWidget {
  const SubmitKycDottedContainer({
    super.key,
    this.child,
    this.enabled = true,
    this.onTap,
    this.isError = false,
    this.selfie,
  });
  final Widget? child;
  final bool enabled;
  final VoidCallback? onTap;
  final bool isError;
  final File? selfie;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      throttle: true,
      throttleDuration: 300.ms,
      onTap: enabled ? onTap : null,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(color: AppColors.lightBlueFilled),
        alignment: Alignment(0, 0),
        child: SizedBox(
          width: double.infinity,
          child: DottedBorder(
            dashPattern: [10, 5],
            radius: Radius.circular(6),
            color: isError ? AppColors.red : AppColors.grey,
            padding: EdgeInsets.all(AppSpacing.lg),
            child: selfie != null
                ? SizedBox(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(selfie!, fit: BoxFit.cover),
                    ),
                  )
                : child ?? SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
