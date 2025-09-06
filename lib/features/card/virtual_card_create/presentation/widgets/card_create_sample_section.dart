import 'package:app_ui/app_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../card.dart';

class CardCreateSamplesSection extends StatelessWidget {
  const CardCreateSamplesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CardCreateSamplesCubit(context.read<CreateVirtualCardCubit>()),
      child: CardCreateSamplesView(),
    );
  }
}

class CardCreateSamplesView extends StatefulWidget {
  const CardCreateSamplesView({super.key});

  @override
  State<CardCreateSamplesView> createState() => _CardCreateSamplesViewState();
}

class _CardCreateSamplesViewState extends State<CardCreateSamplesView> {
  late CarouselSliderController carouselController;
  @override
  void initState() {
    super.initState();
    carouselController = CarouselSliderController();
  }

  void updateCarouselIndex(index, String title) {
    carouselController.jumpToPage(index);
    context.read<CardCreateSamplesCubit>().updateCarouselIndex(index);

    openSnackbar(
      SnackbarMessage.loading(
        title: '${index == 0 ? title : 'Platinum $title'} Selected',
        // timeout: Duration(milliseconds: 100),
      ),
      clearIfQueue: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = context.select(
      (CardCreateSamplesCubit cubit) => cubit.state,
    );
    final isMasterCard = context.select(
      (CreateVirtualCardCubit cubit) => cubit.state.isMasterCard,
    );
    final title = isMasterCard ? 'Mastercard' : 'Visa';

    return Column(
      spacing: AppSpacing.lg,
      children: [
        CarouselSlider.builder(
          itemCount: 2,
          itemBuilder: (context, index, realIndex) => Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: index != 1
                ? VirtualATMCreateCard(
                    cardBrand: isMasterCard,
                    onTap: () => updateCarouselIndex(index, title),
                  )
                : VirtualPlatinumCard(
                    cardBrand: isMasterCard,
                    onTap: () => updateCarouselIndex(index, title),
                  ),
          ),
          carouselController: carouselController,
          options: CarouselOptions(
            viewportFraction: 0.8,
            height: 150,
            enableInfiniteScroll: false,
            padEnds: false,
            initialPage: activeIndex,
            onPageChanged: (index, reason) => updateCarouselIndex(index, title),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.xs,
          children: List.generate(
            2,
            (index) => GestureDetector(
              onTap: () => updateCarouselIndex(index, title),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: index != activeIndex ? 37 : 21,
                height: AppSpacing.xs,
                decoration: BoxDecoration(
                  color: index != activeIndex
                      ? AppColors.brightGrey
                      : AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardCreateSamplesCubit extends Cubit<int> {
  final CreateVirtualCardCubit createVirtualCardCubit;
  CardCreateSamplesCubit(this.createVirtualCardCubit) : super(0);

  void updateCarouselIndex(int index) {
    createVirtualCardCubit.updateCardPlatinum(index);
    emit(index);
  }
}
