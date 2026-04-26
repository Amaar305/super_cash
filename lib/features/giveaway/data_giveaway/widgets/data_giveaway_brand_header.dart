import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';

class DataGiveawayBrandHeader extends StatelessWidget {
  const DataGiveawayBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _LogoMark(),
        const Gap.h(AppSpacing.sm),
        Text(
          'Data Ether',
          style: poppinsTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF14223A),
          ),
        ),
        const Spacer(),
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF9C4B8), Color(0xFFF5D9CF)],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 6,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 10,
                    color: Color(0xFFC49A8E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LogoMark extends StatelessWidget {
  const _LogoMark();

  @override
  Widget build(BuildContext context) {
    const stroke = Color(0xFF14223A);
    return SizedBox(
      width: 18,
      height: 18,
      child: Stack(
        children: [
          Positioned(left: 0, top: 5, child: _dot(stroke)),
          Positioned(left: 5, top: 0, child: _dot(stroke)),
          Positioned(left: 5, bottom: 0, child: _dot(stroke)),
          Positioned(right: 0, top: 5, child: _ring(stroke)),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
    );
  }

  Widget _ring(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
    );
  }
}
