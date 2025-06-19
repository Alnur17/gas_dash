import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/profile/controllers/profile_controller.dart';
import 'package:gas_dash/app/modules/user/subscription/controllers/subscription_controller.dart';
import 'package:gas_dash/app/modules/user/subscription/views/subscription_view.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_car_card.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';

class AfterSubscriptionView extends GetView<SubscriptionController> {
  const AfterSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final subscriptionController = Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text('Subscription', style: titleStyle),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: Obx(() => subscriptionController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : subscriptionController.errorMessage.isNotEmpty
          ? Center(child: Text(subscriptionController.errorMessage.value))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlanCard(),
              sh20,
              Text(
                'Delivery Fee',
                style: h3,
              ),
              sh12,
              DeliveryCard(),
              sh20,
              Text(
                'Vehicle List',
                style: h3,
              ),
              sh12,
              // Display vehicle list dynamically
              Obx(() => subscriptionController
                  .subscriptionVehicleList.isEmpty
                  ? const Text('No vehicles found')
                  : Column(
                children: subscriptionController
                    .subscriptionVehicleList
                    .map((vehicle) => Padding(
                  padding:
                  const EdgeInsets.only(bottom: 12),
                  child: CustomCarCard(
                    name: vehicle.make ?? 'Unknown',
                    model: vehicle.model ?? 'Unknown',
                    year: vehicle.year?.toString() ??
                        'Unknown',
                  ),
                ))
                    .toList(),
              )),
            ],
          ),
        ),
      )),
    );
  }
}

// sh20,
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text('+ Add New', style: h5.copyWith(color: Colors.blue)),
//     CustomButton(
//       height: 40,
//       width: 130,
//       text: 'Upgrade Plan',
//       onPressed: () {},
//       gradientColors: AppColors.gradientColorGreen,
//       textStyle: h5.copyWith(
//         color: AppColors.white,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ],
// ),

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final remeningDuration =
        profileController.myProfileData.value?.remeningDurationDay ?? 0.0;
    final totalDuration = profileController.myProfileData.value?.durationDay ??
        1.0; // Avoid division by zero
    final progress = totalDuration > 0 ? remeningDuration / totalDuration : 0.0;

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileController.myProfileData.value?.title ??
                      'No Membership',
                  style: h3,
                ),
                SizedBox(height: 8.0),
                Text(
                  '${remeningDuration.toStringAsFixed(0)} / ${totalDuration.toStringAsFixed(0)}',
                  style: h5,
                ),
                SizedBox(height: 8.0),
                LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  // Ensure value is between 0 and 1
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                  minHeight: 6.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Reset On June 30, 2020',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ],
            ),
          ),
          sw8,
          CustomButton(
            height: 40,
            width: 130,
            text: 'Upgrade Plan',
            onPressed: () {},
            gradientColors: AppColors.gradientColorGreen,
            textStyle: h5.copyWith(
                color: AppColors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppImages.deliveryCar,
                      scale: 4,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '${profileController.myProfileData.value?.freeDeliverylimit} free delivery left',
                      style: h5,
                    ),
                  ],
                ),
                sh12,
                CustomButton(
                  height: 40,
                  width: 130,
                  text: 'Upgrade Plan',
                  onPressed: () {
                    Get.to(()=> SubscriptionView());
                  },
                  gradientColors: AppColors.gradientColorGreen,
                  textStyle: h5.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
