import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/helper/upload_widget.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../../common/widgets/custom_circular_container.dart';

class DriverProofOfDeliveryView extends GetView {
  const DriverProofOfDeliveryView({super.key});

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
          'Proof Of Delivery',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload Photo',
                  style: h5,
                ),
                Image.asset(
                  AppImages.close,
                  scale: 4,
                ),
              ],
            ),
            sh8,
            UploadWidget(
              onTap: () {},
              imagePath: AppImages.add,
              label: 'Choose File',
            ),
            sh20,
            CustomButton(
              text: 'Submit',
              onPressed: () {
                _showSubmissionCompletedModal(context);
              },
              gradientColors: AppColors.gradientColorGreen,
            ),
          ],
        ),
      ),
    );
  }

  void _showSubmissionCompletedModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // for rounded corners effect
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circle Icon with green check
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.gradientColorGreen[1].withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(AppImages.submit,scale: 4,),
              ),),
              const SizedBox(height: 16),
              Text(
                'Your Submission is Completed',
                style: h3.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Return to Home',
                onPressed: () {},
                gradientColors: AppColors.gradientColorGreen,
              ),
            ],
          ),
        );
      },
    );
  }
}
