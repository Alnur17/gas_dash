import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_images/app_images.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import '../widgets/custom_button.dart';

class ActiveOrder extends StatelessWidget {
  final String orderId;
  final String location;
  final int fuelAmount;
  final String fuelType;
  final VoidCallback onAcceptPressed;
  final VoidCallback onViewDetailsPressed;

  const ActiveOrder({
    super.key,
    required this.orderId,
    required this.location,
    required this.fuelAmount,
    required this.fuelType,
    required this.onAcceptPressed,
    required this.onViewDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID #$orderId',
              style: h3,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Image.asset(
                  AppImages.locationRed,
                  scale: 4,
                ),
                SizedBox(width: 8),
                Text(location),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fuel Amount',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('$fuelAmount Litres'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fuel Type',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(fuelType),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
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
      ),
    );
  }
}
