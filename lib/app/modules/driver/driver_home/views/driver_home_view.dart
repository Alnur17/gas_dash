import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_home/views/notification_view.dart';
import 'package:gas_dash/common/helper/fuel_and_service_card.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_row_header.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/active_order.dart';
import '../../../../../common/helper/earnings_card.dart';
import '../controllers/driver_home_controller.dart';

class DriverHomeView extends GetView<DriverHomeController> {
  const DriverHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Image.asset(
              AppImages.homeLogo,
              scale: 4,
            ),
            Text(
              'GAS DASH',
              style: h3.copyWith(fontWeight: FontWeight.w700),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(()=> NotificationView());
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: AppColors.silver,
                      ),
                    ),
                  ),
                  child: Image.asset(
                    AppImages.notification,
                    scale: 4,
                  )),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh20,
            Text(
              'Earning Overview',
              style: h3,
            ),
            sh12,
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
            Text(
              'Recent Request',
              style: h3,
            ),
            sh12,
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return FuelAndServiceCard(
                    fuelAmount: '5 gallons',
                    fuelType: 'Premium',
                    location: '789 Pine Rd',
                    onAcceptPressed: () {},
                    onViewDetailsPressed: () {},
                    fuelIconPath: AppImages.fuelFiller,
                    locationIconPath: AppImages.locationRed,
                  );
                },
              ),
            ),
            sh20,
            CustomRowHeader(
              title: 'Active Order',
              onTap: () {},
            ),
            sh8,
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ActiveOrder(
                    orderId: '5758',
                    location: '1901 Thornridge Cir, Shiloh, Hawaii',
                    fuelAmount: 15,
                    fuelType: 'Premium Fuel',
                    onAcceptPressed: () {},
                    onViewDetailsPressed: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
