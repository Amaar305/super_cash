import 'dart:math' as math;
import 'dart:ui';

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

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _ambientController;
  late final AnimationController _glowController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoTilt;
  late final Animation<double> _titleOpacity;
  late final Animation<Offset> _titleOffset;
  late final Animation<double> _haloIntensity;

  @override
  void initState() {
    super.initState();
    _introController =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1800),
          )
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // _onIntroAnimationComplete();
              context.read<AppCubit>().appStarted();
            }
          })
          ..forward();

    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    )..repeat();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);

    _logoScale =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(
              begin: 0.6,
              end: 1.08,
            ).chain(CurveTween(curve: Curves.easeOutBack)),
            weight: 70,
          ),
          TweenSequenceItem(
            tween: Tween<double>(
              begin: 1.08,
              end: 1,
            ).chain(CurveTween(curve: Curves.easeInOut)),
            weight: 30,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _introController,
            curve: const Interval(0, 0.75),
          ),
        );

    _logoOpacity = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0, 0.5, curve: Curves.easeOut),
    );

    _logoTilt = Tween<double>(begin: -0.08, end: 0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.1, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _titleOpacity = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.55, 1, curve: Curves.easeOut),
    );

    _titleOffset = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _introController,
            curve: const Interval(0.6, 1, curve: Curves.easeOutCubic),
          ),
        );

    _haloIntensity = Tween<double>(begin: 0.35, end: 0.75).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _introController.dispose();
    _ambientController
      ..stop()
      ..dispose();
    _glowController
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = context.displaySmall?.copyWith(
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
    );

    return AppScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _AnimatedBackground(ambientAnimation: _ambientController),
          Positioned.fill(
            child: IgnorePointer(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 72, sigmaY: 72),
                child: const SizedBox.shrink(),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _ambientController,
            builder: (context, _) => Stack(
              fit: StackFit.expand,
              children: [
                _buildAurora(
                  alignment: Alignment.topLeft,
                  baseOffset: const Offset(-60, -40),
                  phase: 0,
                  colors: const [Color(0xFF5A8EFF), Color(0xFF92E3FF)],
                  size: 320,
                  travel: const Offset(38, 26),
                ),
                _buildAurora(
                  alignment: Alignment.bottomRight,
                  baseOffset: const Offset(50, 60),
                  phase: 0.5,
                  colors: const [Color(0xFF142D6B), Color(0xFF4063FF)],
                  size: 360,
                  travel: const Offset(-32, -24),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.xlg,
              children: [
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _introController,
                    _glowController,
                  ]),
                  builder: (context, _) {
                    final glow = _haloIntensity.value * _logoOpacity.value;
                    return Opacity(
                      opacity: _logoOpacity.value,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 240,
                            height: 240,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(
                                    0xFF3B82F6,
                                  ).withValues(alpha: glow),
                                  AppColors.transparent,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF5EA9FF,
                                  ).withValues(alpha: glow),
                                  blurRadius: 60,
                                  spreadRadius: 12,
                                ),
                              ],
                            ),
                          ),
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..rotateZ(_logoTilt.value),
                            child: Transform.scale(
                              scale: _logoScale.value,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(120),
                                  border: Border.all(
                                    color: AppColors.white.withValues(
                                      alpha: 0.18,
                                    ),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.white.withValues(alpha: 0.22),
                                      AppColors.white.withValues(alpha: 0.06),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.white.withValues(
                                        alpha: 0.12,
                                      ),
                                      blurRadius: 28,
                                      spreadRadius: 6,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(120),
                                  child: Assets.images.logo.image(
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                FadeTransition(
                  opacity: _titleOpacity,
                  child: SlideTransition(
                    position: _titleOffset,
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF9FE2FF),
                          Color(0xFF6D8CFF),
                          Color(0xFF4EC5FF),
                        ],
                      ).createShader(bounds),
                      child: Text(
                        AppStrings.appName,
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAurora({
    required Alignment alignment,
    required Offset baseOffset,
    required Offset travel,
    required double phase,
    required List<Color> colors,
    required double size,
  }) {
    final t = (_ambientController.value + phase) % 1;
    final eased = (math.sin(t * math.pi * 2) + 1) / 2;
    final offset = Offset(
      baseOffset.dx + travel.dx * eased,
      baseOffset.dy + travel.dy * eased,
    );

    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: offset,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors
                  .map((color) => color.withValues(alpha: 0.18 + eased * 0.22))
                  .toList(),
            ),
            boxShadow: [
              BoxShadow(
                color: colors.first.withValues(alpha: 0.12 + eased * 0.18),
                blurRadius: size * 0.7,
                spreadRadius: size * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedBackground extends StatelessWidget {
  const _AnimatedBackground({required this.ambientAnimation});

  final Animation<double> ambientAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ambientAnimation,
      builder: (context, _) {
        final t = ambientAnimation.value;
        final wave = (math.sin(t * math.pi * 2) + 1) / 2;
        final base = AppColors.primaryDarkBlue;
        final mid = Color.lerp(
          AppColors.deepBlue,
          const Color(0xFF060C1F),
          wave,
        )!;
        final accent = Color.lerp(
          const Color(0xFF1E3AFF),
          const Color(0xFF3BC9FF),
          wave * 0.6,
        )!;
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [base, mid, accent.withValues(alpha: 0.9)],
              stops: const [0, 0.55, 1],
            ),
          ),
        );
      },
    );
  }
}
