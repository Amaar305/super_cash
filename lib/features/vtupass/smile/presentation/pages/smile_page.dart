import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/reusable_coming_soon_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import '../presentation.dart';

class SmilePage extends StatelessWidget {
  const SmilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SmileView();
  }
}

class SmileView extends StatelessWidget {
  const SmileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.smile),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),

      body: ReusableComingSoonWidget(
        text: 'Smile services will be available soon. Stay tuned for updates.',
      ),

      // body: ListView.builder(
      //   itemCount: 11,
      //   padding: EdgeInsets.all(AppSpacing.lg),
      //   itemBuilder: (context, index) {
      //     if (index == 0) {
      //       return Padding(
      //         padding: const EdgeInsets.only(bottom: AppSpacing.md),
      //         child: Text(AppStrings.smileVoiceAndDataBundles),
      //       );
      //     }
      //     return SmileVoiceTile(
      //       onTap: () => context.push(
      //         AppRoutes.smileProceed,
      //         extra: context.read<SmileCubit>(),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
