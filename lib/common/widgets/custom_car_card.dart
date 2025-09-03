import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_images/app_images.dart';

import '../app_text_style/styles.dart';

class CustomCarCard extends StatelessWidget {
  final String name;
  final String model;
  final String year;

  const CustomCarCard({
    super.key,
    required this.name,
    required this.model,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            AppImages.car,
            scale: 4,
          ),
          SizedBox(width: 8.0),
          Text(
            '$name $model, $year',
            style: h5,
          )
        ],
      ),
    );
  }
}
