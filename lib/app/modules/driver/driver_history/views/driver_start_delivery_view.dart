import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/controllers/driver_history_controller.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_live_track_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:get/get.dart';

class DriverStartDeliveryView extends StatefulWidget {
  const DriverStartDeliveryView({super.key});

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
                          '#798796',
                          style: h5,
                        ),
                        Text(
                          'ETA: 10 mins | Distance: 2 miles',
                          style: h5,
                        ),
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
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(AppImages.profileImageTwo),
                        ),
                        sw12,
                        Text(
                          'Sarah J.',
                          style: h3,
                        ),
                      ],
                    ),
                    sh12,
                    Text(
                      '5 gallons , Premium',
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
                          '789 Pine Rd',
                          style: h5,
                        ),
                      ],
                    ),
                    sh12,
                    Obx(
                      () => driverHistoryController.isOnTheWay.value
                          ? CustomButton(
                              text: 'On the Way',
                              onPressed: () {}, // Disabled after marking
                              gradientColors: AppColors.gradientColorGreen,
                            )
                          : CustomButton(
                              text: 'Mark as On the Way',
                              onPressed: () {
                                driverHistoryController.markAsOnTheWay();
                              }, // Call the method to update state
                              borderColor: AppColors.primaryColor,
                              textColor: AppColors.primaryColor,
                            ),
                    ),
                    sh12,
                    Obx(
                      () => driverHistoryController.isOnTheWay.value
                          ? Column(
                              children: [
                                sh20,
                                Container(
                                  //padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Placeholder for the map
                                      Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.asset(
                                              AppImages.mapImage,
                                              scale: 4,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      sh12,
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImages.locationRed,
                                            scale: 4,
                                          ),
                                          sw8,
                                          Text(
                                            '1401 Thornridge Cir, Shiloh',
                                            style: h5,
                                          ),
                                        ],
                                      ),
                                      sh12,
                                      CustomButton(
                                        text: 'Live Track',
                                        onPressed: () {
                                          Get.to(()=> DriverLiveTrackView());
                                        },
                                        gradientColors:
                                            AppColors.gradientColorGreen,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
