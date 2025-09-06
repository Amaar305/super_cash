import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class InquiryWidget extends StatelessWidget {
  const InquiryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconContainer(
          color: AppColors.red,
          imagePath: 'youtube.png',
          child: Assets.images.youtube.image(
            color: AppColors.white,
          ),
          onTap: () {},
        ),
        IconContainer(
          color: AppColors.green,
          imagePath: 'whatsapp.png',
          child: Assets.images.whatsapp.image(
            color: AppColors.white,
          ),
          onTap: () {},
        ),
        IconContainer(
          color: AppColors.blue,
          imagePath: 'facebook.png',
          child: Assets.images.facebook.image(
            color: AppColors.white,
          ),
          onTap: () {},
        ),
        IconContainer(
          color: AppColors.buttonColor,
          imagePath: 'tiktok.png',
          child: Assets.images.tiktok.image(
            color: AppColors.white,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
