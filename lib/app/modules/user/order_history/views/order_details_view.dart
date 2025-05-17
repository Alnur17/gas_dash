import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';

class OrderDetailsView extends GetView {
  const OrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text('View Details', style: titleStyle),
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.back,
              scale: 4,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh20,
              Text(
                'Order ID',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                '04-58',
                style: h6,
              ),
              sh12,
              Text(
                'Order Date',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                '10 Dec, 2025 10:38 AM',
                style: h6,
              ),
              sh12,
              Text(
                'Location',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Row(
                children: [
                  Image.asset(
                    AppImages.locationRed,
                    scale: 4,
                  ),
                  sw8,
                  Text(
                    '19456 Oak St, Denver, CO 80202',
                    style: h6,
                  ),
                ],
              ),
              sh12,
              Text(
                'Vehicle',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                'Ford F-150, 2020, ~20% fuel',
                style: h6,
              ),
              sh12,
              Text(
                'Fuel Type',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                'Premium',
                style: h6,
              ),
              sh12,
              Text(
                'Amount',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                '15 gallons',
                style: h6,
              ),
              sh12,
              Text(
                'Delivery Fee',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                '\$0.00',
                style: h6,
              ),
              sh12,
              Text(
                'Tips',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                '\$0.00',
                style: h6,
              ),
              sh12,
              Text(
                'Total',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                '\$0.00',
                style: h6,
              ),
              sh12,
              Text(
                'Status',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                'In Process',
                style: h6.copyWith(color: Colors.deepPurpleAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}