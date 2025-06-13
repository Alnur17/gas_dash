import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/helper/earnings_card.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/app/modules/driver/driver_earning/views/driver_withdraw_view.dart';
import 'package:get/get.dart';
import '../controllers/driver_earning_controller.dart';

class DriverEarningView extends GetView<DriverEarningController> {
  const DriverEarningView({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverEarningController controller = Get.put(DriverEarningController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Earning overview',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() => Column(
          children: [
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.errorMessage.value.isNotEmpty
                ? Center(
              child: Text(
                controller.errorMessage.value,
                style: h4.copyWith(color: AppColors.red),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: EarningsCard(
                    gradientColor: AppColors.gradientColorBlue,
                    title: 'Total Earnings',
                    amount: controller.totalEarnings.value
                        .toStringAsFixed(2),
                    //dropDown: 'Last Month',
                  ),
                ),
                sw8,
                EarningsCard(
                  backgroundColor: AppColors.primaryColor,
                  title: 'Today',
                  amount: controller.todayEarnings.value
                      .toStringAsFixed(2), // Display todayEarnings
                ),
              ],
            ),
            sh20,
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(colors: AppColors.gradientColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your Balance',
                    style: h4.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                  sh5,
                  Text(
                    '\$1000', // Update dynamically if needed
                    style: h1.copyWith(color: AppColors.white),
                  ),
                  sh24,
                  CustomButton(
                    text: 'Request Withdraw',
                    onPressed: () {
                      Get.to(() => DriverWithdrawView());
                    },
                    gradientColors: AppColors.gradientColor,
                    textStyle: h3.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}