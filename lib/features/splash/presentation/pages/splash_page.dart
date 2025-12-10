import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/app_strings/app_string.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<Offset> _logoOffset;
  late final Animation<double> _nameOpacity;
  late final Animation<Offset> _nameOffset;
  late final Animation<double> _taglineOpacity;
  late final Animation<Offset> _taglineOffset;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1700),
          )
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              context.read<AppCubit>().appStarted();
            }
          })
          ..forward();

    _logoScale = Tween<double>(begin: 1.12, end: 0.94).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    _logoOffset = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.12))
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 0.75, curve: Curves.easeOutCubic),
          ),
        );

    _nameOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 1, curve: Curves.easeIn),
    );

    _nameOffset = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.45, 1, curve: Curves.easeOutCubic),
          ),
        );

    _taglineOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.65, 1, curve: Curves.easeIn),
    );

    _taglineOffset =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.65, 1, curve: Curves.easeOutCubic),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameStyle = context.titleLarge?.copyWith(
      // color: AppColors.deepBlue,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    );

    final taglineStyle = context.bodyMedium?.copyWith(
      color: AppColors.emphasizeGrey,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    );

    return AppScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SlideTransition(
                  position: _logoOffset,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Assets.images.logo.image(
                      width: 160,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: _nameOpacity,
                  child: SlideTransition(
                    position: _nameOffset,
                    child: Text(
                      AppStrings.appName.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: nameStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 42),
              child: FadeTransition(
                opacity: _taglineOpacity,
                child: SlideTransition(
                  position: _taglineOffset,
                  child: Text(
                    AppStrings.appTagline,
                    textAlign: TextAlign.center,
                    style: taglineStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
