import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_home/views/notification_view.dart';
import 'package:gas_dash/app/modules/user/profile/controllers/profile_controller.dart';
import 'package:gas_dash/common/helper/fuel_and_service_card.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/helper/earnings_card.dart';
import 'package:get/get.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import '../../../../../common/helper/active_order.dart';
import '../../driver_earning/controllers/driver_earning_controller.dart';
import '../../driver_history/views/driver_start_delivery_view.dart';
import '../controllers/driver_home_controller.dart';

class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key});

  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView> {
  final DriverHomeController controller = Get.put(DriverHomeController());
  final ProfileController profileController = Get.put(ProfileController());
  final DriverEarningController driverEarningController =
  Get.put(DriverEarningController());


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
        child: Obx(() => RefreshIndicator(
              onRefresh: () async{
                await controller.fetchAssignedOrders();
                await profileController.getMyProfile();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                            title: 'Total Earnings',
                            amount: driverEarningController.totalEarnings.value
                                .toStringAsFixed(2),
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
                        : controller.pendingOrders.isEmpty
                            ? Center(
                                child: Text('No pending orders available',
                                    style: h5))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.pendingOrders.length,
                                itemBuilder: (context, index) {
                                  final order = controller.pendingOrders[index];
                                  return FuelAndServiceCard(
                                    emergencyImage: AppImages.emergency,
                                    emergency: order.emergency ?? false,
                                    fuelAmount:
                                        '${order.amount?.toStringAsFixed(2) ?? '0.00'} gallons',
                                    fuelType: order.orderType ?? 'Unknown',
                                    location: order.location?.coordinates !=
                                            null
                                        ? '[${order.location!.coordinates[0]}, ${order.location!.coordinates[1]}]'
                                        : 'Unknown',
                                    onAcceptPressed: () =>
                                        controller.acceptOrder(order.id ?? ''),
                                    onViewDetailsPressed: () => controller
                                        .viewOrderDetails(order.id ?? ''),
                                    fuelIconPath: AppImages.fuelFiller,
                                    locationIconPath: AppImages.locationRed,
                                  );
                                },
                              ),
                    sh20,
                    Text(
                      'Active Order',
                      style: h3,
                    ),
                    // CustomRowHeader(
                    //   title: 'Active Order',
                    //   onTap: () {},
                    // ),
                    sh8,
                    controller.inProgressOrders.isEmpty
                        ? Center(
                            child:
                                Text('No active orders available', style: h5))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.inProgressOrders.length,
                            itemBuilder: (context, index) {
                              final order = controller.inProgressOrders[index];
                              return ActiveOrder(
                                emergencyImage: AppImages.emergency,
                                emergency: order.emergency ?? false,
                                orderId: order.id ?? 'Unknown',
                                location: order.location?.coordinates != null
                                    ? '[${order.location!.coordinates[0]}, ${order.location!.coordinates[1]}]'
                                    : 'Unknown',
                                fuelAmount: order.amount != null ? double.parse(order.amount.toString()) : 0.0,
                                fuelType: order.orderType ?? 'Unknown',
                                onAcceptPressed: () {
                                  Get.to(() => DriverStartDeliveryView(
                                        orderId: order.id ?? 'Unknown',
                                        deliveryId: order.deleveryId ?? '',
                                        customerName:
                                            order.userId?.fullname ?? '',
                                        customerImage: order.userId?.image,
                                        amounts:
                                            '${order.amount?.toStringAsFixed(2) ?? '0.00'} Gallons',
                                        orderName: order.fuelType ?? 'Unknown',
                                        location: order.location?.coordinates !=
                                                null
                                            ? '[${order.location!.coordinates[0]}, ${order.location!.coordinates[1]}]'
                                            : 'Unknown', userId: order.userId!.id.toString(),
                                      ));
                                },
                                onViewDetailsPressed: () =>
                                    controller.viewOrderDetails(order.id ?? ''),
                              );
                            },
                          ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
