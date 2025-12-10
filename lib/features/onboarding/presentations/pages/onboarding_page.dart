import 'package:app_ui/app_ui.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/onboarding/presentations/widgets/onboarding.dart';
import 'package:super_cash/features/onboarding/presentations/widgets/onboarding_stepper.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingView();
  }
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: AppStrings.appName,
      description:
          'Welcome to ${AppStrings.appName} App.\nEnjoy seamless features and fast transactions at a very user friendly cost',
      image: Assets.images.onboarding1.image(fit: BoxFit.cover),
    ),
    OnboardingData(
      title: 'Super Fast Transaction',
      description:
          'Send and receive money instantly with secure, lightning-fast processing anytime, anywhere.',
      image: Assets.images.onboarding2.image(fit: BoxFit.cover),
    ),
    OnboardingData(
      title: 'Super Earn',
      description:
          'Welcome to ${AppStrings.appName} App.\nEnjoy seamless features and fast transactions at a very user friendly cost',
      image: Assets.images.onboarding3.image(fit: BoxFit.cover),
    ),
  ];
  int currentIndex = 0;
  late PageController controller;

  bool get reached => currentIndex == _onboardingData.length - 1;

  void onIndexChanged(int index) => setState(() {
    currentIndex = index;
    controller.jumpToPage(index);
  });

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: _skip, child: Text('Skip'))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gap.v(AppSpacing.xxxlg),
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: controller,
                onPageChanged: onIndexChanged,
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return Onboarding(onboardingData: data);
                },
              ),
            ),

            Expanded(
              child: Row(
                children: [
                  OnboardingStepper(
                    currentIndex: currentIndex,
                    length: _onboardingData.length,
                  ),
                  Gap.h(AppSpacing.xxlg),
                  Expanded(
                    child: PrimaryButton(
                      label: reached ? 'Done' : 'Next',
                      onPressed: _finished,
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

  Future<void> _skip() async {
    context.read<AppCubit>().completeOnboarding();
  }

  Future<void> _finished() async {
    if (reached) {
      _skip();
      return;
    }
    final val = currentIndex += 1;
    onIndexChanged(val);
  }
}

class OnboardingData extends Equatable {
  final Widget image;
  final String title;
  final String description;

  const OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [image, title, description];
}
