import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../../core/app_strings/app_string.dart';

class CardFeaturesSection extends StatefulWidget {
  const CardFeaturesSection({super.key});

  @override
  State<CardFeaturesSection> createState() => _CardFeaturesSectionState();
}

class _CardFeaturesSectionState extends State<CardFeaturesSection> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_scrollController.hasClients) {
        double newOffset = _scrollController.offset + 20; // Adjust scroll speed
        if (newOffset >= _scrollController.position.maxScrollExtent) {
          newOffset = 0; // Reset to start if end is reached
        }
        _scrollController.animateTo(
          newOffset,
          duration: Duration(seconds: 1),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.cardFeatures,
          style: poppinsTextStyle(
            fontSize: AppSpacing.md - 1,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: AppSpacing.sm,
            children: List.generate(AppStrings.cardFeaturesList.length, (
              index,
            ) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.xs,
                children: [
                  SizedBox.square(
                    dimension: 12,
                    child: Assets.images.circleCheck.image(),
                  ),
                  Flexible(
                    child: Text(
                      AppStrings.cardFeaturesList[index],
                      style: MonaSansTextStyle.label(
                        fontSize: 10,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
