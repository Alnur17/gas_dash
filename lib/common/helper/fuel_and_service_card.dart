import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import '../widgets/custom_button.dart';

class FuelAndServiceCard extends StatelessWidget {
  final String fuelAmount;
  final String fuelType;
  final String location;
  final VoidCallback onAcceptPressed;
  final VoidCallback onViewDetailsPressed;
  final String fuelIconPath;
  final String locationIconPath;
  final String emergencyImage;
  final bool emergency;

  const FuelAndServiceCard({
    super.key,
    required this.fuelAmount,
    required this.fuelType,
    required this.location,
    required this.onAcceptPressed,
    required this.onViewDetailsPressed,
    required this.fuelIconPath,
    required this.locationIconPath,
    required this.emergencyImage,
    required this.emergency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                fuelIconPath,
                scale: 4,
              ),
              sw8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       // '$fuelAmount, $fuelType',
                        fuelType,
                        style: h5.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (emergency) ...[
                        sw5,
                        Image.asset(
                          emergencyImage,
                          scale: 4,
                        ),
                      ],
                    ],
                  ),
                  sh5,
                  Row(
                    children: [
                      Image.asset(
                        locationIconPath,
                        scale: 4,
                      ),
                      sw8,
                      Text(
                        location,
                        style: h6,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          sh16,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  height: 40,
                  text: 'Accept',
                  onPressed: onAcceptPressed,
                  borderColor: AppColors.primaryColor,
                  textColor: AppColors.primaryColor,
                ),
              ),
              sw8,
              Expanded(
                child: CustomButton(
                  height: 40,
                  text: 'View Details',
                  onPressed: onViewDetailsPressed,
                  gradientColors: AppColors.gradientColorGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}