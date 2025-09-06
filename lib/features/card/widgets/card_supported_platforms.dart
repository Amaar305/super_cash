import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

class CardSupportedPlatforms extends StatefulWidget {
  const CardSupportedPlatforms({super.key});

  @override
  State<CardSupportedPlatforms> createState() => _CardSupportedPlatformsState();
}

class _CardSupportedPlatformsState extends State<CardSupportedPlatforms> {
  late final ScrollController _scrollController;
  late final List<Widget> logoPaths;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    logoPaths = [
      Assets.images.netflix.image(
        width: AppSpacing.xxlg,
        height: AppSpacing.xxlg,
      ),
      Assets.images.appleMusic.image(
        width: AppSpacing.xxlg,
        height: AppSpacing.xxlg,
      ),
      Assets.images.jumia.image(
        width: AppSpacing.xxlg,
        height: AppSpacing.xxlg,
      ),
      Assets.images.spotify.image(
        width: AppSpacing.xxlg,
        height: AppSpacing.xxlg,
      ),
      Assets.images.netflix.image(
        width: AppSpacing.xxlg,
        height: AppSpacing.xxlg,
      ),
      Assets.images.appleMusic.image(
        width: AppSpacing.xxlg,
        height: AppSpacing.xxlg,
      ),
      Assets.images.jumia.image(
        width: AppSpacing.xxlg,
        height: AppSpacing.xxlg,
      ),
      Assets.images.spotify.image(
        width: AppSpacing.xxlg,
        height: AppSpacing.xxlg,
      ),

      // Add more logo paths here
    ];
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
      children: [
        Row(
          children: [
            Text(
              '${AppStrings.cardSupports}:',
              style: poppinsTextStyle(
                fontSize: AppSpacing.md - 1,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 80, // Adjust height as needed
          child: ListView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: logoPaths.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: logoPaths[index],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
