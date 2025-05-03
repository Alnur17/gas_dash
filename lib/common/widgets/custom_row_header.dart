import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';

class CustomRowHeader extends StatelessWidget {
  const CustomRowHeader({
    super.key,
    required this.title,
   // required this.subtitle,
    required this.onTap,
  });

  final String title;
  //final Widget subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: h3,
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text('See All',style: h6.copyWith(color: AppColors.darkRed),),
              sw5,
              Image.asset(AppImages.arrowRight,scale: 4,color: AppColors.darkRed,)
            ],
          ),
        ),
      ],
    );
  }
}



//style: h5.copyWith(color: AppColors.textColorBlue,fontWeight: FontWeight.bold),