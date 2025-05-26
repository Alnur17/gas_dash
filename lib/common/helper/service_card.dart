import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import '../widgets/custom_button.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String price;
  final String buttonText;
  final VoidCallback onServiceTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.price,
    required this.buttonText,
    required this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.silver),
        gradient: LinearGradient(
          colors: AppColors.gradientColorBlue,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: h5.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            price,
            style: h3.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          sh12,
          CustomButton(
            text: buttonText,
            onPressed: onServiceTap,
            gradientColors: AppColors.gradientColor,
            width: 150,
            height: 40,
          ),
        ],
      ),
    );
  }
}