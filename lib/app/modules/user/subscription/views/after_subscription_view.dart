import 'package:flutter/material.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_car_card.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';

class AfterSubscriptionView extends GetView {
  const AfterSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
              CustomCarCard(
                name: 'Ford',
                model: 'F-150',
                year: '2020',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  'Plus plan',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '10/30 days used',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                LinearProgressIndicator(
                  value: 10 / 30,
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
                      // Replace with your truck icon asset
                      scale: 4,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '4 of 6 free deliveries',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                LinearProgressIndicator(
                  value: 4 / 6,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                  minHeight: 6.0,
                ),
                sh12,
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
          ),
        ],
      ),
    );
  }
}
