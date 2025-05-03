import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';

class GoogleButton extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;
  final Color borderColor;

  const GoogleButton({
    super.key,
    required this.assetPath,
    required this.label,
    required this.onTap,
    this.borderColor = AppColors.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath,scale: 4,),
            sw16,
            Text(
              label,
              style:  h3.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
