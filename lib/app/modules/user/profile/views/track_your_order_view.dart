import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/order_history/controllers/order_history_controller.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:get/get.dart';

import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/helper/socket_service.dart';
import '../../../../../common/helper/track_order_card.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../../track_order_details/views/live_tracking_view.dart';

class TrackYourOrderView extends StatefulWidget {
  const TrackYourOrderView({super.key});

  @override
  State<TrackYourOrderView> createState() => _TrackYourOrderViewState();
}

class _TrackYourOrderViewState extends State<TrackYourOrderView> {
final OrderHistoryController orderHistoryController = Get.put(OrderHistoryController());

final SocketService socketService = Get.put(SocketService());

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
      body: Obx(() => orderHistoryController.inProcessOrders.isEmpty == true? Center(child: Text("Empty order"),) : ListView.builder(
        itemCount: orderHistoryController.inProcessOrders.length,
        itemBuilder: (context, index) {
          final order = orderHistoryController.inProcessOrders[index];
          return TrackOrderCard(
            emergency: order.emergency ?? false,
            emergencyImage: AppImages.emergency,
            orderId: order.id.toString(),
            dateTime: order.createdAt.toString(),
            status: order.orderStatus.toString(),
            fuelAmount: order.amount.toString(),
            fuelType: order.fuelType.toString(),
            paidPrice: double.parse(order.price.toString()).toStringAsFixed(2),
            onTrack: () {
              socketService.socket.emit('joinOrderRoom', "${order.driverId?.id}"); // Emit location data
           //   Get.to(() => TrackOrderDetailsView());
              Get.to(()=> LiveTrackingView(index: index,));
              // socket emit

          }

          );
        },
      )),
    );
  }
}
