import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_home/views/notification_view.dart';
import 'package:gas_dash/common/helper/fuel_and_service_card.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_row_header.dart';
import 'package:gas_dash/common/helper/active_order.dart';
import 'package:gas_dash/common/helper/earnings_card.dart';
import 'package:get/get.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import '../../driver_earning/controllers/driver_earning_controller.dart';
import '../controllers/driver_home_controller.dart';

class DriverHomeView extends GetView<DriverHomeController> {
  const DriverHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverHomeController controller = Get.put(DriverHomeController());
    final DriverEarningController driverEarningController = Get.put(DriverEarningController());
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
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => NotificationView());
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
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() => Column(
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
                        title: 'Total Earnings',
                        amount: driverEarningController.totalEarnings.value
                            .toStringAsFixed(2),
                        //dropDown: 'Last Month',
                      ),
                    ),
                    sw8,
                    EarningsCard(
                      backgroundColor: AppColors.primaryColor,
                      title: 'Today',
                      amount: driverEarningController.todayEarnings.value
                          .toStringAsFixed(2),
                    ),
                  ],
                ),
                sh20,
                Text(
                  'Recent Request',
                  style: h3,
                ),
                sh12,
                controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: controller.assignedOrders.isEmpty
                            ? Center(
                                child: Text('No orders available', style: h5))
                            : ListView.builder(
                                itemCount: controller.assignedOrders.length,
                                itemBuilder: (context, index) {
                                  final order =
                                      controller.assignedOrders[index];
                                  // final locationString = order.location?.coordinates != null
                                  //     ? '[${order.location!.coordinates[0]}, ${order.location!.coordinates[1]}]'
                                  //     : 'Unknown Location';
                                  return FuelAndServiceCard(
                                    fuelAmount:
                                        '${order.finalAmountOfPayment?.toStringAsFixed(2) ?? '0.00'} gallons',
                                    fuelType: order.orderType ?? 'Unknown',
                                    location: order.zipCode ?? 'Unknown',
                                    onAcceptPressed: () =>
                                        controller.acceptOrder(order.id ?? ''),
                                    onViewDetailsPressed: () => controller
                                        .viewOrderDetails(order.id ?? ''),
                                    // onAcceptPressed: () => controller.acceptOrder(order.id ?? ''),
                                    // onViewDetailsPressed: () => controller.viewOrderDetails(order.id ?? ''),
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
                    itemCount: 4, // Replace with active orders API if available
                    itemBuilder: (context, index) {
                      return ActiveOrder(
                        orderId: '5758',
                        location: '1901 Thorn ridge Cir, Shiloh, Hawaii',
                        fuelAmount: 15,
                        fuelType: 'Premium Fuel',
                        onAcceptPressed: () {},
                        onViewDetailsPressed: () {},
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
