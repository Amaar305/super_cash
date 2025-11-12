import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

/// A reusable dialog that surfaces app-update details and provides
/// actions to trigger an update immediately or defer it.
class AppUpdateDialog extends StatelessWidget {
  ///
  const AppUpdateDialog({
    required this.appUpdate,
    required this.isCritical,
    required this.onUpdateNow,
    super.key,
    this.onMaybeLater,
  });

  ///
  final AppUpdate appUpdate;

  ///
  final bool isCritical;

  ///
  final VoidCallback onUpdateNow;

  ///
  final VoidCallback? onMaybeLater;

  List<String> get _changelogItems {
    return appUpdate.changelog
        .split(RegExp(r'[\r\n]+'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final changelogItems = _changelogItems;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.blue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.system_update_alt, color: AppColors.blue),
              ),
            ),
            const Gap.v(16),
            Text(
              isCritical ? 'Update Required' : 'New Update Available',
              style: textTheme.titleLarge?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap.v(8),
            Text(
              'Version ${appUpdate.latestVersionName} is ready to install. '
              // ignore: lines_longer_than_80_chars
              'Upgrade now to enjoy the latest enhancements and keep things secure.',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.darkGrey),
            ),
            if (changelogItems.isNotEmpty) ...[
              const Gap.v(16),
              Text(
                'What’s new',
                style: textTheme.labelLarge?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap.v(8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 180),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: changelogItems
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '• ',
                                  style: TextStyle(color: AppColors.black),
                                ),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
            const Gap.v(24),
            if (isCritical)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onUpdateNow,
                  child: const Text('Update now'),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: onMaybeLater,
                      child: const Text('Maybe later'),
                    ),
                  ),
                  const Gap.h(12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: onUpdateNow,
                      child: const Text('Update now'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
