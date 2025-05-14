import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../../common/app_text_style/styles.dart';

class DriverOrderDetailsView extends GetView {
  const DriverOrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text('Order Details', style: titleStyle),
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.back,
              scale: 4,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh8,
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(AppImages.profileImageTwo),
                  ),
                  sw8,
                  Text(
                    'Sarah J.',
                    style: h6,
                  ),
                ],
              ),
              sh12,
              Text(
                'Order ID',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                '555-987-6543',
                style: h6,
              ),
              sh12,
              Text(
                'Delivery Date & time',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                '06 Feb,2025',
                style: h6,
              ),
              sh12,
              Text(
                'Location',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Row(
                children: [
                  Image.asset(
                    AppImages.locationRed,
                    scale: 4,
                  ),
                  sw8,
                  Text(
                    '19456 Oak St, Denver, CO 80202 ',
                    style: h6,
                  ),
                ],
              ),
              sh12,
              Text(
                'Vehicle',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                'Ford F-150, 2020, ~20% fuel',
                style: h6,
              ),
              sh12,
              Text(
                'Fuel Type',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                'Premium',
                style: h6,
              ),
              sh12,
              Text(
                'Amount',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                '15 gallons ',
                style: h6,
              ),
              sh20,
              CustomButton(
                text: 'Start Delivery',
                onPressed: () {},
                gradientColors: AppColors.gradientColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
