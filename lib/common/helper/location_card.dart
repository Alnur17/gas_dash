import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/modules/user/order_fuel/controllers/order_fuel_controller.dart';
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
    print("location>>>>>> $locationText");

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
          // Obx(() => Text(
          //   'Zip Code: ${controller.zipCode.value?.isNotEmpty == true ? controller.zipCode.value : 'Not set'}',
          //   style: h6,
          // )),
          sh12,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: CustomButton(
                  text: buttonText,
                  onPressed: onButtonPressed,
                  height: 40,
                  borderRadius: 8,
                  backgroundColor: Colors.blue[50],
                  //imageAssetPath: AppImages.edit,
                  iconColor: AppColors.blueLight,
                  textStyle: buttonTextStyle ??
                      h5.copyWith(
                        color: AppColors.blueLight,
                      ),
                ),
              ),
              //sw8,
              // CustomButton(
              //   text: 'Set Zip Code',
              //   onPressed: () {
              //     controller.promptForZipCode();
              //   },
              //   height: 40,
              //   width: 120,
              //   borderRadius: 8,
              //   backgroundColor: Colors.blue[50],
              //   //imageAssetPath: AppImages.edit,
              //   iconColor: AppColors.blueLight,
              //   textStyle: h5.copyWith(
              //     color: AppColors.blueLight,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}