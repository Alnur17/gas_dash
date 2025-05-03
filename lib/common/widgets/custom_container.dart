import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final double? height;
  final TextStyle? textStyle;
  final String imagePath;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback onTap;

  const CustomContainer({
    super.key,
    required this.text,
    this.textStyle,
    required this.imagePath,
    this.backgroundColor = AppColors.white,
    this.padding,
    this.borderRadius,
    this.height = 54,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: textStyle ?? h3),
            Image.asset(imagePath, scale: 4),
          ],
        ),
      ),
    );
  }
}
