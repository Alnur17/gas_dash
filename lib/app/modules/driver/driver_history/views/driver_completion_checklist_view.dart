import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/controllers/driver_completion_checklist_controller.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_proof_of_delivery_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class DriverCompletionChecklistView
    extends GetView<DriverCompletionChecklistController> {
  const DriverCompletionChecklistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 2,
          ),
        ),
        title: Text(
          'Completion Checklist',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please confirm the following steps were completed',
              style: h3,
            ),
            sh20,
            Text(
              'Did you close the gas cap?',
              style: h3,
            ),
            sh12,
            Row(
              children: [
                Image.asset(
                  AppImages.checkBoxFilled,
                  scale: 4,
                ),
                sw8,
                Text(
                  'Yes',
                  style: h5,
                ),
              ],
            ),
            sh8,
            Row(
              children: [
                Image.asset(
                  AppImages.checkBox,
                  scale: 4,
                ),
                sw8,
                Text(
                  'No',
                  style: h5,
                ),
              ],
            ),
            sh20,
            Text(
              'Did you wipe away any fuel spills?',
              style: h3,
            ),
            sh12,
            Row(
              children: [
                Image.asset(
                  AppImages.checkBoxFilled,
                  scale: 4,
                ),
                sw8,
                Text(
                  'Yes',
                  style: h5,
                ),
              ],
            ),
            sh8,
            Row(
              children: [
                Image.asset(
                  AppImages.checkBox,
                  scale: 4,
                ),
                sw8,
                Text(
                  'No',
                  style: h5,
                ),
              ],
            ),
            sh20,
            Text(
              'Did you ensure the vehicle is in a safe condition?',
              style: h3,
            ),
            sh12,
            Row(
              children: [
                Image.asset(
                  AppImages.checkBoxFilled,
                  scale: 4,
                ),
                sw8,
                Text(
                  'Yes',
                  style: h5,
                ),
              ],
            ),
            sh8,
            Row(
              children: [
                Image.asset(
                  AppImages.checkBox,
                  scale: 4,
                ),
                sw8,
                Text(
                  'No',
                  style: h5,
                ),
              ],
            ),
            sh20,
            CustomButton(
              text: 'Next',
              onPressed: () {
                Get.to(() => DriverProofOfDeliveryView());
              },
              gradientColors: AppColors.gradientColorGreen,
            ),
          ],
        ),
      ),
    );
  }
}
