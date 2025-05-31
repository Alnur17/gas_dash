import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../dashboard/views/dashboard_view.dart';

class PaymentSuccessView extends GetView {
  const PaymentSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.paymentSuccess,
              scale: 4,
            ),
            sh20,
            Text(
              ' Your Payment Successfully Done',
              style: h2,
            ),
            sh5,
            Text(
              'We will notify you about the schedule. Stay tuned for updates',
              style: h3.copyWith(
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            sh20,
            CustomButton(
              text: 'Back to Homepage',
              onPressed: () {
                Get.offAll(()=> DashboardView());
              },
              gradientColors: AppColors.gradientColor,
            ),
          ],
        ),
      ),
    );
  }
}
