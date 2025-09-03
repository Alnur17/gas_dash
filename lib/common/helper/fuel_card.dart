import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_images/app_images.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class FuelCard extends StatelessWidget {
  final String title;
  //final String? number;
  final String buttonText;
  final double height;
  final double width;
  final EdgeInsets margin;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const FuelCard({
    super.key,
    required this.title,
    //required this.number,
    //this.number,
    required this.buttonText,
    this.height = 65,
    this.width = double.infinity,
    this.margin = const EdgeInsets.only(left: 30, right: 20),
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: borderColor),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -10,
              top: -5,
              bottom: -5,
              child: Image.asset(
                AppImages.boxShape,
                scale: 4,
              ),
            ),
            Positioned(
              left: 0,
              top: 10,
              bottom: 0,
              child: Text(
                buttonText,
                style: h5.copyWith(color: AppColors.white,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // Positioned(
            //   left: -2,
            //   top: 0,
            //   bottom: 10,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         number,
            //         style: h3.copyWith(fontSize: 20, color: AppColors.white),
            //       ),
            //       Text(
            //         buttonText,
            //         style: h1.copyWith(color: AppColors.white, fontSize: 8),
            //       ),
            //     ],
            //   ),
            // ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: h1.copyWith(fontSize: 20, color: AppColors.white),
              ),
            ),
            Positioned(
              right: -4,
              top: 0,
              bottom: 0,
              child: Image.asset(
                AppImages.oilLoader,
                scale: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
