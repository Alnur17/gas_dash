import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/emergency_fuel/views/schedule_delivery_from_calender_view.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';

class ScheduleDeliveryView extends GetView {
  const ScheduleDeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Schedule Delivery',
          style: titleStyle,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh20,
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage(AppImages.scheduleDeliveryImage),
                    scale: 4,
                    fit: BoxFit.cover),
              ),
            ),
            sh20,
            Text(
              'Estimated arrival',
              style: h3,
            ),
            sh5,
            Text(
              'Estimated arrival in 25 minutes',
              style: h5,
            ),
            sh30,
            CustomButton(
              text: 'Next',
              onPressed: () {
                Get.to(()=> ScheduleDeliveryFromCalenderView());
              },
              gradientColors: AppColors.gradientColorGreen,
            ),
          ],
        ),
      ),
    );
  }
}
