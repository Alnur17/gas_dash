import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class FinalConfirmationView extends GetView {
  final String? orderId;

  const FinalConfirmationView({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
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
        title: Text('Final Confirmation', style: titleStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh20,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location',
                        style: h5.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('19456 Oak St, Denver, CO 80202', style: h6),
                    const SizedBox(height: 16),
                    Text('Vehicle',
                        style: h5.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Ford F-150, 2020, ~20% fuel', style: h6),
                    const SizedBox(height: 16),
                    Text('Delivery Fee',
                        style: h5.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('\$5.00', style: h6),
                    const SizedBox(height: 16),
                    Text('Service Fee',
                        style: h5.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('\$60.00', style: h6),
                  ],
                ),
              ),
            ),
            sh30,
            CustomButton(
              text: 'Next',
              onPressed: () {},
              gradientColors: AppColors.gradientColorGreen,
            ),
          ],
        ),
      ),
    );
  }
}
