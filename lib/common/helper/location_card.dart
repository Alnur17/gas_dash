import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import '../widgets/custom_button.dart';

class LocationCard extends StatelessWidget {
  final String locationText;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final TextStyle? locationLabelStyle;
  final TextStyle? locationTextStyle;
  final TextStyle? buttonTextStyle;

  const LocationCard({
    super.key,
    required this.locationText,
    required this.buttonText,
    required this.onButtonPressed,
    this.locationLabelStyle,
    this.locationTextStyle,
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
                AppImages.locationRed,
                scale: 4,
              ),
              sw12,
              Text(
                'Location',
                style: locationLabelStyle ??
                    h5.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          sh5,
          Text(
            locationText,
            style: locationTextStyle ?? h6,
          ),
          sh12,
          CustomButton(
            text: buttonText,
            onPressed: onButtonPressed,
            height: 40,
            width: 180,
            borderRadius: 8,
            backgroundColor: Colors.blue[50],
            imageAssetPath: AppImages.edit,
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