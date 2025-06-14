import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_earning/controllers/driver_earning_controller.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/helper/earnings_card.dart';

class DriverWithdrawView extends GetView<DriverEarningController> {
  final String myBalance;
  const DriverWithdrawView(this.myBalance, {super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    Get.put(DriverEarningController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Withdraw',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EarningsCard(
              gradientColor: AppColors.gradientColorBlue,
              title: 'Total Balance',
              amount: myBalance, // This could be dynamic, e.g., from DriverEarningController
            ),
            sh12,
            Text(
              'Withdraw Amount',
              style: h5,
            ),
            sh8,
            CustomTextField(
              hintText: '\$1000',
              controller: controller.amountController,
              //keyboardType: TextInputType.number,
            ),
            sh12,
            Text(
              'Card Holder Name',
              style: h5,
            ),
            sh8,
            CustomTextField(
              hintText: 'TANZIDA',
              controller: controller.cardHolderNameController,
            ),
            sh12,
            Text(
              'Card Number',
              style: h5,
            ),
            sh8,
            CustomTextField(
              hintText: '3536 3532 1235 0987',
              controller: controller.cardNumberController,
              //keyboardType: TextInputType.number,
            ),
            sh20,
            Obx(() => CustomButton(
              text: controller.isLoading.value ? 'Processing...' : 'Withdraw',
              onPressed: controller.isLoading.value
                  ? (){}
                  : controller.submitWithdrawRequest,
              gradientColors: AppColors.gradientColorGreen,
            )),
          ],
        ),
      ),
    );
  }
}