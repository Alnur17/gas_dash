import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import '../widgets/custom_button.dart';

class VehicleCard extends StatelessWidget {
  final String buttonText;
  final VoidCallback onButtonPressed;
  final String imageAssetPath;
  final String labelText;
  final TextStyle? labelStyle;
  final TextStyle? buttonTextStyle;

  const VehicleCard({
    super.key,
    required this.buttonText,
    required this.onButtonPressed,
    required this.imageAssetPath,
    this.labelText = 'Add Vehicle',
    this.labelStyle,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                imageAssetPath,
                scale: 4,
              ),
              sw12,
              Text(
                labelText,
                style: labelStyle ??
                    h5.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          sh12,
          CustomButton(
            text: buttonText,
            onPressed: onButtonPressed,
            height: 40,
            width: 100,
            borderRadius: 8,
            backgroundColor: Colors.blue[50],
            imageAssetPath: AppImages.add,
            iconColor: AppColors.blueLight,
            textStyle: buttonTextStyle ??
                h5.copyWith(
                  color: AppColors.blueLight,
                ),
          ),
        ],
      ),
    );
  }
}