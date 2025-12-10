import 'package:app_ui/app_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/home/home.dart';

class HomeImageSlider extends StatefulWidget {
  const HomeImageSlider({super.key});

  @override
  State<HomeImageSlider> createState() => _HomeImageSliderState();
}

class _HomeImageSliderState extends State<HomeImageSlider> {
  late CarouselSliderController carouselController;
  @override
  void initState() {
    super.initState();
    carouselController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppSpacing.spaceUnit);
    final sliders = context.select(
      (HomeCubit cubit) => cubit.state.homeSettings?.imageSliders ?? [],
    );

    if (sliders.isEmpty) return SizedBox.shrink();
    return CarouselSlider.builder(
      itemCount: sliders.length,
      itemBuilder: (context, index, realIndex) {
        return HomeSliderImage(
          borderRadius: borderRadius,
          slider: sliders[index],
        );
      },
      carouselController: carouselController,
      options: CarouselOptions(
        height: 120,
        autoPlay: true,
        reverse: true,
        viewportFraction: 0.8,
      ),
    );
  }
}

class HomeSliderImage extends StatelessWidget {
  const HomeSliderImage({
    super.key,
    required this.borderRadius,
    required this.slider,
  });

  final BorderRadius borderRadius;
  final ImageSlider slider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.only(top: AppSpacing.md, right: AppSpacing.sm),
      decoration: BoxDecoration(borderRadius: borderRadius),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          slider.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Text('Image not available'));
          },
        ),
      ),
    );
  }
}
