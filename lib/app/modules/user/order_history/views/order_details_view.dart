import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../controllers/order_history_controller.dart';

class OrderDetailsView extends GetView<OrderHistoryController> {
  final String? amount;
  const OrderDetailsView(this.amount, {super.key});

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final order = controller.singleOrder.value;
        if (order == null || order.data == null) {
          return const Center(child: Text('No order details available'));
        }

        final orderData = order.data!;
        final displayStatus = orderData.orderStatus == 'InProgress' ? 'In Process' : 'Completed';

        return SingleChildScrollView(
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
                  orderData.id ?? 'N/A',
                  style: h6,
                ),
                sh12,
                Text(
                  'Order Date',
                  style: h5.copyWith(fontWeight: FontWeight.w600),
                ),
                sh5,
                Text(
                  orderData.createdAt?.toString() ?? 'Unknown',
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
                      orderData.zipCode ?? 'Unknown',
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
                  orderData.vehicleId ?? 'Unknown Vehicle',
                  style: h6,
                ),
                sh12,
                Text(
                  'Fuel Type',
                  style: h5.copyWith(fontWeight: FontWeight.w600),
                ),
                sh5,
                Text(
                  orderData.orderType ?? 'Unknown',
                  style: h6,
                ),
                sh12,
                Text(
                  'Amount',
                  style: h5.copyWith(fontWeight: FontWeight.w600),
                ),
                sh5,
                Text(
                  (orderData.presetAmount == true || orderData.customAmount == true)
                      ? '${amount ?? '0.00'} gallons'
                      : 'Unknown',
                  style: h6,
                ),
                sh12,
                Text(
                  'Delivery Fee',
                  style: h5.copyWith(fontWeight: FontWeight.w600),
                ),
                sh5,
                Text(
                  '\$${orderData.deliveryFee?.toStringAsFixed(2) ?? '0.00'}',
                  style: h6,
                ),
                sh12,
                Text(
                  'Tips',
                  style: h5.copyWith(fontWeight: FontWeight.w600),
                ),
                sh5,
                Text(
                  '\$${orderData.tip?.toStringAsFixed(2) ?? '0.00'}',
                  style: h6,
                ),
                sh12,
                Text(
                  'Total',
                  style: h5.copyWith(fontWeight: FontWeight.w600),
                ),
                sh5,
                Text(
                  '\$${orderData.finalAmountOfPayment?.toStringAsFixed(2) ?? '0.00'}',
                  style: h6,
                ),
                sh12,
                Text(
                  'Status',
                  style: h5.copyWith(fontWeight: FontWeight.w600),
                ),
                sh5,
                Text(
                  displayStatus,
                  style: h6.copyWith(
                    color: displayStatus == 'In Process'
                        ? Colors.deepPurpleAccent
                        : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}