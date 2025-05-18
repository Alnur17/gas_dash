import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/track_order_details/views/track_order_details_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:get/get.dart';

import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/helper/track_order_card.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class TrackYourOrderView extends StatefulWidget {
  const TrackYourOrderView({super.key});

  @override
  State<TrackYourOrderView> createState() => _TrackYourOrderViewState();
}

class _TrackYourOrderViewState extends State<TrackYourOrderView> {
  final List<Map<String, String>> orders = [
    {
      "orderId": "5758",
      "dateTime": "10 Dec 2025 at 10:39 AM",
      "status": "In Process",
      "fuelAmount": "15 Litres",
      "fuelType": "Premium",
      "paidPrice": "\$65"
    },
    {
      "orderId": "5759",
      "dateTime": "11 Dec 2025 at 2:10 PM",
      "status": "Delivered",
      "fuelAmount": "20 Litres",
      "fuelType": "Regular",
      "paidPrice": "\$85"
    },
    // add more orders here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Track Your Order',style: titleStyle,),
        centerTitle: true,
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
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return TrackOrderCard(
            orderId: order["orderId"]!,
            dateTime: order["dateTime"]!,
            status: order["status"]!,
            fuelAmount: order["fuelAmount"]!,
            fuelType: order["fuelType"]!,
            paidPrice: order["paidPrice"]!,
            onTrack: () {
              Get.to(() => TrackOrderDetailsView());
            },
          );
        },
      ),
    );
  }
}
