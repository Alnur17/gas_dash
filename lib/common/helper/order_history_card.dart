import 'package:flutter/material.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';

import '../app_color/app_colors.dart';
import '../widgets/custom_button.dart';

class OrderHistoryCard extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String fuelQuantity;
  final String fuelType;
  final String status;
  final String? price; // Optional price field
  final String? buttonText1; // Optional button 1 text
  final String? buttonText2; // Optional button 2 text
  final VoidCallback? onButton1Pressed; // Optional callback for button 1
  final VoidCallback? onButton2Pressed; // Optional callback for button 2

  const OrderHistoryCard({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.fuelQuantity,
    required this.fuelType,
    required this.status,
    this.price, // Optional price
    this.buttonText1, // Optional button 1
    this.buttonText2, // Optional button 2
    this.onButton1Pressed, // Optional callback for button 1
    this.onButton2Pressed, // Optional callback for button 2
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryColor)
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 8,
        //     offset: Offset(0, 2),
        //   ),
        //],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID #$orderId',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink, // Pink color for the status
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            orderDate,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fuelQuantity,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fuel Amount',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fuelType,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fuel Type',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              if (price != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '\$$price',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Paid Price',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          // Show price only if it's provided
          // if (price != null)
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         '\$$price',
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       const SizedBox(width: 10),
          //       Text(
          //         'Paid Price',
          //         style: TextStyle(
          //           fontSize: 12,
          //           color: Colors.grey[600],
          //         ),
          //       ),
          //     ],
          //   ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (buttonText1 != null && onButton1Pressed != null)
                Expanded(
                  child: CustomButton(
                    text: buttonText1!,
                    backgroundColor: AppColors.transparent,
                    borderColor: AppColors.green,
                    textColor: AppColors.green,
                    onPressed: onButton1Pressed!,
                  ),
                ),
              sw12,
              // Show button 2 only if text and onPressed are provided
              if (buttonText2 != null && onButton2Pressed != null)
                Expanded(
                  child: CustomButton(
                    text: buttonText2!,
                    gradientColors: AppColors.gradientColor,
                    onPressed: onButton2Pressed!,
                  ),
                ),
            ],
          ),
          // Show button 1 only if text and onPressed are provided
        ],
      ),
    );
  }
}
