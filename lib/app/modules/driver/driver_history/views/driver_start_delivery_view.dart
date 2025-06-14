import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/controllers/driver_history_controller.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_live_track_view.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/station_near_you_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_circular_container.dart';

class DriverStartDeliveryView extends StatefulWidget {
  final String orderId;
  final String deliveryId;
  final String customerName;
  final String? customerImage;
  final String amounts;
  final String orderName;
  final String? location;

  const DriverStartDeliveryView(
      {super.key,
      required this.orderId,
      required this.deliveryId,
      required this.customerName,
      required this.customerImage,
      required this.amounts,
      required this.orderName,
      required this.location});

  @override
  State<DriverStartDeliveryView> createState() =>
      _DriverStartDeliveryViewState();
}

class _DriverStartDeliveryViewState extends State<DriverStartDeliveryView> {
  final DriverHistoryController driverHistoryController =
      Get.put(DriverHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 2,
          ),
        ),
        title: Text(
          'Start Delivery',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID',
                          style: h3,
                        ),
                        Text(
                          '#${widget.orderId}',
                          style: h5,
                        ),
                        // Text(
                        //   'ETA: 10 mins | Distance: 2 miles',
                        //   style: h5,
                        // ),
                      ],
                    ),
                    Image.asset(
                      AppImages.copy,
                      scale: 4,
                    ),
                  ],
                ),
              ),
              sh20,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                         CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(widget.customerImage ?? AppImages.profileImageTwo),
                        ),
                        sw12,
                        Text(
                          widget.customerName,
                          style: h3,
                        ),
                      ],
                    ),
                    sh12,
                    Text(
                      '${widget.amounts} , ${widget.orderName}',
                      style: h3,
                    ),
                    sh8,
                    Row(
                      children: [
                        Image.asset(
                          AppImages.locationRed,
                          scale: 4,
                        ),
                        sw8,
                        Text(
                          widget.location.toString(),
                          style: h5,
                        ),
                      ],
                    ),
                    // sh12,
                    // Obx(
                    //   () => driverHistoryController.isOnTheWay.value
                    //       ? CustomButton(
                    //           text: 'On the Way',
                    //           onPressed: () {}, // Disabled after marking
                    //           gradientColors: AppColors.gradientColorGreen,
                    //         )
                    //       : CustomButton(
                    //           text: 'Mark as On the Way',
                    //           onPressed: () {
                    //             driverHistoryController.markAsOnTheWay();
                    //           }, // Call the method to update state
                    //           borderColor: AppColors.primaryColor,
                    //           textColor: AppColors.primaryColor,
                    //         ),
                    // ),
                    sh12,
                    CustomButton(
                      text: 'On the Way',
                      onPressed: () {
                        _showFuelCheckBottomSheet(context);
                      }, // Disabled after marking
                      gradientColors: AppColors.gradientColorGreen,
                    ),
                    // Obx(
                    //   () => driverHistoryController.isOnTheWay.value
                    //       ? Column(
                    //           children: [
                    //             sh20,
                    //             Container(
                    //               //padding: const EdgeInsets.all(12),
                    //               decoration: BoxDecoration(
                    //                 color: AppColors.white,
                    //                 borderRadius: BorderRadius.circular(12),
                    //               ),
                    //               child: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   // Placeholder for the map
                    //                   Container(
                    //                     height: 150,
                    //                     width: double.infinity,
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.grey[300],
                    //                       borderRadius: BorderRadius.circular(12),
                    //                     ),
                    //                     child: ClipRRect(
                    //                         borderRadius:
                    //                             BorderRadius.circular(12),
                    //                         child: Image.asset(
                    //                           AppImages.mapImage,
                    //                           scale: 4,
                    //                           fit: BoxFit.cover,
                    //                         )),
                    //                   ),
                    //                   sh12,
                    //                   Row(
                    //                     children: [
                    //                       Image.asset(
                    //                         AppImages.locationRed,
                    //                         scale: 4,
                    //                       ),
                    //                       sw8,
                    //                       Text(
                    //                         '1401 Thornridge Cir, Shiloh',
                    //                         style: h5,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   sh12,
                    //                   CustomButton(
                    //                     text: 'Live Track',
                    //                     onPressed: () {
                    //                       Get.to(()=> DriverLiveTrackView());
                    //                     },
                    //                     gradientColors:
                    //                         AppColors.gradientColorGreen,
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         )
                    //       : const SizedBox.shrink(),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFuelCheckBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Fuel Check',
                style: h3.copyWith(fontSize: 18),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE9F9FF),
                ),
                child: Image.asset(
                  AppImages.gasStation, // Add this asset to your assets folder
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Before proceeding, please confirm if you need to refuel your vehicle for this order',
                textAlign: TextAlign.center,
                style: h5,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 40,
                      text: 'Yes, I Need Fuel',
                      onPressed: () {
                        Get.to(() => StationNearYouView());
                      },
                      gradientColors: AppColors.gradientColorGreen,
                      textStyle: h7.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  sw5,
                  Expanded(
                    child: CustomButton(
                      height: 40,
                      text: 'No, I Don’t Need Fuel',
                      onPressed: () {
                        Get.to(() => DriverLiveTrackView());
                      },
                      backgroundColor: AppColors.silver,
                      borderColor: AppColors.primaryColor,
                      textStyle: h7.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Get.back();
                  //       // Add your logic here for "Yes, I Need Fuel"
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Color(0xFF539C86), // green color
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       padding: EdgeInsets.symmetric(vertical: 14),
                  //     ),
                  //     child: Text(
                  //       'No, I Don\'t Need Fuel',
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: 12),
                  // Expanded(
                  //   child: OutlinedButton(
                  //     onPressed: () {
                  //       Get.back();
                  //       // Add your logic here for "No, I Don't Need Fuel"
                  //     },
                  //     style: OutlinedButton.styleFrom(
                  //       backgroundColor: Color(0xFFF2F3F4),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       padding: EdgeInsets.symmetric(vertical: 14),
                  //       side: BorderSide(color: Colors.transparent),
                  //     ),
                  //     child: Text(
                  //       "No, I Don't Need Fuel",
                  //       style: TextStyle(color: Colors.black38, fontSize: 16),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
