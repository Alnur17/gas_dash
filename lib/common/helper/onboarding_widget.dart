import 'package:flutter/material.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../app_images/app_images.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  //final String backgroundImage;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                image,
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              ),
              sh20,
              Text(
                title,
                style: h1.copyWith(color: AppColors.textColor),
              ),
              sh16,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AppImages.arrowRightBig,scale: 4,),
                  sw5,
                  Expanded(
                    child: Text(
                      subtitle,
                      style: h4,
                    ),
                  ),
                ],
              ),
              sh150,
            ],
          ),
        ),
      ],
    );
  }
}
