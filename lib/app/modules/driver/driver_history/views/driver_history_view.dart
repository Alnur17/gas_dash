import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_start_delivery_view.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/helper/order_history_card.dart';
import 'package:get/get.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../driver_home/controllers/driver_home_controller.dart';

class DriverHistoryView extends StatefulWidget {
  const DriverHistoryView({super.key});

  @override
  State<DriverHistoryView> createState() => _DriverHistoryViewState();
}

class _DriverHistoryViewState extends State<DriverHistoryView> {
  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    Get.put(DriverHomeController());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Order History',
            style: titleStyle,
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            // Active Orders (InProgress)
            OrderStatusSection(status: 'InProgress'),
            // Pending Orders
            OrderStatusSection(status: 'Pending'),
            // Completed Orders (Delivered)
            OrderStatusSection(status: 'Delivered'),
          ],
        ),
      ),
    );
  }
}

class OrderStatusSection extends GetView<DriverHomeController> {
  final String status;

  const OrderStatusSection({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Select the appropriate order list based on status
    final orders = status == 'Pending'
        ? controller.pendingOrders
        : status == 'InProgress'
            ? controller.inProgressOrders
            : controller.deliveredOrders;

    return Obx(() => orders.isEmpty
        ? Center(child: Text('No $status orders available', style: h5))
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderHistoryCard(
                emergency: order.emergency ?? false,
                emergencyImage: AppImages.emergency,
                orderId: order.id ?? 'Unknown',
                orderDate: _formatDate(order.createdAt),
                fuelQuantity:
                    '${order.amount?.toStringAsFixed(2) ?? '0.00'} Gallons',
                fuelType: order.orderType ?? 'Unknown',
                price: order.finalAmountOfPayment?.toStringAsFixed(2) ?? '0.00',
                status: _mapStatusToDisplay(status),
                buttonText1: _getButtonText1(status),
                buttonText2: _getButtonText2(status),
                onButton1Pressed: () {
                  if (status == 'InProgress') {
                    Get.to(() => DriverStartDeliveryView(
                          orderId: order.id ?? 'Unknown',
                          deliveryId: order.deleveryId ?? '',
                          customerName: order.userId?.fullname ?? '',
                          customerImage: order.userId?.image,
                          amounts:
                              '${order.amount?.toStringAsFixed(2) ?? '0.00'} Gallons',
                          orderName: order.fuelType ?? 'Unknown',
                          location: order.location?.coordinates != null
                              ? '[${order.location!.coordinates[0]}, ${order.location!.coordinates[1]}]'
                              : 'Unknown',
                        ));
                  } else if (status == 'Pending') {
                    controller.acceptOrder(order.id ?? '');
                  }
                },
                onButton2Pressed: () {
                  controller.viewOrderDetails(order.id ?? '');
                },
              );
            },
          ));
  }

  // Format DateTime to desired string format
  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown Date';
    final formatter = DateFormat('dd MMM yyyy \'at\' hh:mm a');
    return formatter.format(date);
  }

  // Map internal status to display status
  String _mapStatusToDisplay(String status) {
    switch (status) {
      case 'InProgress':
        return 'Active';
      case 'Pending':
        return 'Pending';
      case 'Delivered':
        return 'Completed';
      default:
        return status;
    }
  }

  // Get button text for Button 1 based on status
  String? _getButtonText1(String status) {
    switch (status) {
      case 'InProgress':
        return 'Start Delivery';
      case 'Pending':
        return 'Accept';
      case 'Delivered':
        return null; // No button for Delivered
      default:
        return null;
    }
  }

  // Get button text for Button 2 based on status
  String? _getButtonText2(String status) {
    switch (status) {
      case 'InProgress':
      case 'Pending':
      case 'Delivered':
        return 'View Details';
      default:
        return null;
    }
  }
}
