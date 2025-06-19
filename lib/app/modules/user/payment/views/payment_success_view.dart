import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/order_history/controllers/order_history_controller.dart';
import 'package:gas_dash/app/modules/user/payment/controllers/payment_controller.dart';
import 'package:gas_dash/app/modules/user/profile/controllers/profile_controller.dart';

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
    final ProfileController profileController = Get.put(ProfileController());
    final OrderHistoryController orderHController = Get.put(OrderHistoryController());
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
              textAlign: TextAlign.center,
            ),
            sh8,
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
                orderHController.fetchOrderHistory();
                profileController.getMyProfile();
              },
              gradientColors: AppColors.gradientColor,
            ),
          ],
        ),
      ),
    );
  }
}
