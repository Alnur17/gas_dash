import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_earning/views/driver_withdraw_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';

import 'package:get/get.dart';

import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/earnings_card.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../controllers/driver_earning_controller.dart';

class DriverEarningView extends GetView<DriverEarningController> {
  const DriverEarningView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title:  Text('Earning overview'
        ,style: titleStyle,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: EarningsCard(
                    gradientColor: AppColors.gradientColorBlue,
                    title: 'Earnings',
                    amount: '165.00',
                    dropDown: 'Last Month',
                  ),
                ),
                sw8,
                EarningsCard(
                  //gradientColor: AppColors.gradientColorGreen,
                  backgroundColor: AppColors.primaryColor,
                  title: 'Today',
                  amount: '65.00',
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
                    '\$1000',
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
                        fontWeight: FontWeight.w500, color: AppColors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
