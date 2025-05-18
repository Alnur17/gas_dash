import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

class TrackOrderCard extends StatelessWidget {
  final String orderId;
  final String dateTime;
  final String status;
  final String fuelAmount;
  final String fuelType;
  final String paidPrice;
  final VoidCallback onTrack;

  const TrackOrderCard({
    super.key,
    required this.orderId,
    required this.dateTime,
    required this.status,
    required this.fuelAmount,
    required this.fuelType,
    required this.paidPrice,
    required this.onTrack,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.green.shade200;
    final statusColor = Colors.deepPurpleAccent.shade100;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top row: Order ID and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Order ID ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueGrey.shade900),
                    ),
                    TextSpan(
                      text: '#$orderId',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueGrey.shade900),
                    ),
                  ],
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Date and time
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dateTime,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Info Row: 3 columns
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Fuel Amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fuelAmount,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blueGrey.shade900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fuel Ammount',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  )
                ],
              ),
              // Fuel Type
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    fuelType,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blueGrey.shade900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fuel Type',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  )
                ],
              ),
              // Paid Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    paidPrice,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blueGrey.shade900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Paid Price',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Track Order Button
          CustomButton(
            text: 'Track Order',
            onPressed: onTrack,
            gradientColors: AppColors.gradientColorGreen,
          ),
        ],
      ),
    );
  }
}
