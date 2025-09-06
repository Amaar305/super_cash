import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/reusable_coming_soon_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamPinPage extends StatelessWidget {
  const ExamPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExamPinView();
  }
}

class ExamPinView extends StatelessWidget {
  const ExamPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.examPin),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: ReusableComingSoonWidget(
        text:
            'Exam Pin services will be available soon. Stay tuned for updates.',
      ),
      // body: AppConstrainedScrollView(
      //   padding: EdgeInsets.all(AppSpacing.lg),
      //   child: Column(
      //     spacing: AppSpacing.xlg,
      //     children: [
      //       ExamPinExamProvider(),
      //       ExamPinForm(),
      //       ExamPinButton(),
      //     ],
      //   ),
      // ),
    );
  }
}
