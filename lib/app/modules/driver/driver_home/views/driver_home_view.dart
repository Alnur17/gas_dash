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
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/active_order.dart';
import '../../../../../common/helper/local_store.dart';
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
  List<Map<String, dynamic>> autoAssignList = [];
  Timer? _locationTimer;

  @override
  void initState() {
    super.initState();
    socketService.init().then((_) {
      if (socketService.socket.connected) {
        socketService.socket.on('newOrder', (data) {
          print('newOrder event received in DriverHomeView: $data');

          // Ensure orderId is a string for consistent comparison
          String orderId = data['orderId'].toString();
          bool orderExists = autoAssignList.any((order) => order['orderId'].toString() == orderId);

          if (!orderExists) {
            setState(() {
              autoAssignList.add({...data, 'orderId': orderId});
            });
            print('Added to Autoassign list: $autoAssignList');
          } else {
            print('Order with ID $orderId already exists in Autoassign list');
          }
        });

        socketService.socket.on('deliveryRejectionResponse', (data) {
          debugPrint(">>>>>>>>>>>>>>>== Order Reject Done: $data");
          // Ensure orderId is a string
          String orderId = data['orderId'].toString();
          setState(() {
            autoAssignList.removeWhere((order) => order['orderId'].toString() == orderId);
          });
          print('Removed order ID $orderId from Autoassign list: $autoAssignList');
        });

        socketService.socket.on('orderResponse', (data) {
          debugPrint(">>>>>>>>>>>>>>>== Order Accept Done: $data");
          // Ensure orderId is a string
          String orderId = data['orderId'].toString();
          setState(() {
            autoAssignList.removeWhere((order) => order['orderId'].toString() == orderId);
          });
          print('Removed order ID $orderId from Autoassign list after orderResponse: $autoAssignList');
        });
      } else {
        print('not connected');
      }
    });
  }

  // Method to stop sending location updates
  void _stopLocationUpdates() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  void disconnect() {
    _stopLocationUpdates();
    socketService.socket.disconnect();
  }

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
                // Autoassign list display
                autoAssignList.isEmpty
                    ? Center(
                    child: Text('No auto-assigned orders available',
                        style: h5))
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: autoAssignList.length,
                  itemBuilder: (context, index) {
                    final order = autoAssignList[index];
                    final orderId = order['orderId']?.toString() ?? 'unknown';
                    final coords = order['location']?['coordinates'];

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
                        emergency: false, // Adjust based on your data
                        fuelAmount:
                        '${order['amount']?.toStringAsFixed(2) ?? '0.00'} gallons',
                        fuelType: 'Order ID \n$orderId',
                        location: locationName,
                        onAcceptPressed: () async {
                          // Call the acceptOrder function
                          await controller.acceptOrder(orderId);

                          // Retrieve deliveryId from LocalStorage
                          final deliveryId = LocalStorage.getData(key: AppConstant.deliveryId);

                          // Emit accept order event
                          final orderData = {
                            "orderId": orderId,
                            "deleveryId": deliveryId ?? "", // Fallback to empty string if null
                          };
                          // Emit accept order event
                          socketService.socket.emit('acceptOrder', orderData);
                          // Immediate removal as fallback
                          setState(() {
                            autoAssignList.removeWhere((order) => order['orderId'].toString() == orderId);
                          });
                          print('Fallback: Removed order ID $orderId from Autoassign list: $autoAssignList');
                          controller.fetchAssignedOrders();
                        },
                        onViewDetailsPressed: () {
                          // // Call the acceptOrder function
                          // await controller.acceptOrder(orderId);
                          //
                          // // Retrieve deliveryId from LocalStorage
                          // final deliveryId = LocalStorage.getData(key: AppConstant.deliveryId);

                          // Emit accept order event
                          final orderData = {
                            "orderId": orderId,
                            //"deleveryId": deliveryId ?? "", // Fallback to empty string if null
                          };
                          // Emit reject order event
                          socketService.socket.emit('rejectOrder', orderData);
                          // Immediate removal as fallback
                          setState(() {
                            autoAssignList.removeWhere((order) => order['orderId'].toString() == orderId);
                          });
                          print('Fallback: Removed order ID $orderId from Autoassign list: $autoAssignList');
                        },
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
                            lat: order.location?.coordinates[1]
                                .toString(),
                            long: order.location?.coordinates[0]
                                .toString(),
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