import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_home/views/notification_view.dart';
import 'package:gas_dash/app/modules/user/profile/controllers/profile_controller.dart';
import 'package:gas_dash/common/helper/fuel_and_service_card.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/helper/earnings_card.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import '../../../../../common/helper/active_order.dart';
import '../../../../../common/helper/socket_service.dart';
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


  final SocketService socketService = Get.put(SocketService());

  Timer? _locationTimer;

  // Method to stop sending location updates
  void _stopLocationUpdates() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  void disconnect() {
    _stopLocationUpdates(); // Stop location updates before disconnecting
    socketService.socket.disconnect();
  }

  // Method to get current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

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
              onRefresh: () async {
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
                                  final orderId = order.id ?? 'unknown';
                                  final coords = order.location?.coordinates;

                                  // Start resolving location if not already done
                                  if (coords != null &&
                                      !controller.locationNames
                                          .containsKey(orderId)) {
                                    controller.resolveLocation(
                                        orderId, coords[1], coords[0]);
                                  }

                                  return Obx(() {
                                    final locationName =
                                        controller.locationNames[orderId] ??
                                            "Loading location...";

                                    return FuelAndServiceCard(
                                      emergencyImage: AppImages.emergency,
                                      emergency: order.emergency ?? false,
                                      fuelAmount:
                                          '${order.amount?.toStringAsFixed(2) ?? '0.00'} gallons',
                                      fuelType: order.orderType ?? 'Unknown',
                                      location: locationName,
                                      onAcceptPressed: () => controller
                                          .acceptOrder(order.id ?? ''),
                                      onViewDetailsPressed: () =>
                                          controller.viewOrderDetails(
                                              order.id ?? '', locationName),
                                      fuelIconPath: AppImages.fuelFiller,
                                      locationIconPath: AppImages.locationRed,
                                    );
                                  });
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
                              final orderId = order.id ?? 'unknown';
                              final coords = order.location?.coordinates;

                              // Start resolving location if not already done
                              if (coords != null &&
                                  !controller.locationNames
                                      .containsKey(orderId)) {
                                controller.resolveLocation(orderId, coords[1],
                                    coords[0]); // latitude, longitude
                              }

                              return Obx(() {
                                final locationName =
                                    controller.locationNames[orderId] ??
                                        "Loading location...";

                                return ActiveOrder(
                                  emergencyImage: AppImages.emergency,
                                  emergency: order.emergency ?? false,
                                  orderId: order.id ?? 'Unknown',
                                  location: locationName,
                                  fuelAmount: order.amount != null
                                      ? double.parse(order.amount.toString())
                                      : 0.0,
                                  fuelType: order.orderType ?? 'Unknown',
                                  onAcceptPressed: () {

                                      // // Cancel any existing timer to avoid duplicates
                                      // _stopLocationUpdates();
                                      //
                                      // _locationTimer = Timer.periodic(Duration(milliseconds: 500), (timer) async {
                                      //   if (socketService.socket.connected) {
                                      //     try {
                                      //       final position = await _getCurrentLocation();
                                      //       final locationData = {
                                      //         "latitude": position.latitude,
                                      //         "longitude": position.longitude,
                                      //         "orderId": order.id,
                                      //       };
                                      //       socketService.socket.emit('getLocation', locationData); // Emit location data
                                      //       print('Emitted location: $locationData');
                                      //     } catch (e) {
                                      //       print('Error getting location: $e');
                                      //     }
                                      //   } else {
                                      //     print('Socket not connected, skipping location emission');
                                      //   }
                                      // });

                                    Get.to(() => DriverStartDeliveryView(
                                          orderId: order.id ?? 'Unknown',
                                          deliveryId: order.deleveryId ?? '',
                                          customerName:
                                              order.userId?.fullname ?? '',
                                          customerImage: order.userId?.image,
                                          amounts:
                                              '${order.amount?.toStringAsFixed(2) ?? '0.00'} Gallons',
                                          orderName:
                                              order.fuelType ?? 'Unknown',
                                          location: locationName,
                                      lat: order.location?.coordinates[1].toString(),
                                      long: order.location?.coordinates[0].toString(),
                                          userId: order.userId!.id.toString(),
                                        ));
                                  },
                                  onViewDetailsPressed: () =>
                                      controller.viewOrderDetails(
                                          order.id ?? '', locationName),
                                );
                              });
                            },
                          ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
