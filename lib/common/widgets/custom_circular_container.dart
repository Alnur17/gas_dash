import 'package:flutter/material.dart';
import '../../../../../../common/app_color/app_colors.dart';

class CustomCircularContainer extends StatelessWidget {
  final String imagePath;
  final double padding;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CustomCircularContainer({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.padding = 12.0,
    this.backgroundColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: backgroundColor,
        ),
        child: Image.asset(
          imagePath,
          scale: 4,
          color: AppColors.black,
        ),
      ),
    );
  }
}