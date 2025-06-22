import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/order_history_card.dart';
import '../../payment/controllers/payment_controller.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  @override
  void initState() {
    super.initState();
    Get.put(OrderHistoryController());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text('Order History', style: titleStyle),
          centerTitle: true,
          bottom: TabBar(
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'In Process'),
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
            OrderStatusSection(status: 'All'),
            OrderStatusSection(status: 'In Process'),
            OrderStatusSection(status: 'Completed'),
          ],
        ),
      ),
    );
  }
}

class OrderStatusSection extends StatelessWidget {
  final String status;

  const OrderStatusSection({super.key, required this.status});

  @override
//   Widget build(BuildContext context) {
//     final OrderHistoryController controller =
//         Get.put(OrderHistoryController());
//
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }
//
//       if (controller.errorMessage.isNotEmpty) {
//         return Center(
//             child: Text(controller.errorMessage.value,
//                 style: const TextStyle(color: Colors.red)));
//       }
//
// // Filter orders based on status
//       final filteredOrders = status == 'All'
//           ? controller.orders
//           : controller.orders.where((order) {
// // Map UI status to API status
//               final apiStatus =
//                   status == 'In Process' ? 'InProgress' : 'Delivered';
//               return order.orderStatus == apiStatus;
//             }).toList();
//
//       if (filteredOrders.isEmpty) {
//         return const Center(child: Text('No orders found'));
//       }
//
//       return ListView.builder(
//         itemCount: filteredOrders.length,
//         itemBuilder: (context, index) {
//           final order = filteredOrders[index];
// // Map API status to UI status for display
//           final displayStatus =
//               order.orderStatus == 'InProgress' ? 'In Process' : 'Completed';
//           return OrderHistoryCard(
//             orderId: order.id ?? 'N/A',
//             orderDate: order.createdAt?.toString() ?? 'Unknown',
//             fuelQuantity: '${order.amount ?? 0} Litres',
//             fuelType: order.fuelType ?? 'Unknown',
//             price: (order.finalAmountOfPayment ?? 0.0).toStringAsFixed(2),
//             status: displayStatus,
//             buttonText1: _getButtonText1(order.orderStatus ?? ''),
//             buttonText2: _getButtonText2(order.orderStatus ?? ''),
//             onButton1Pressed: () {
//               _navigateButton1(order.orderStatus ?? '');
//             },
//             onButton2Pressed: () {
//               Get.to(() => const OrderDetailsView());
//             },
//           );
//         },
//       );
//     });
//   }

  Widget build(BuildContext context) {
    final OrderHistoryController controller = Get.put(OrderHistoryController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(
            child: Text(controller.errorMessage.value,
                style: const TextStyle(color: Colors.red)));
      }

      // Filter orders based on status with null safety
      final filteredOrders = status == 'All'
          ? controller.orders.where((order) {
        final s = order.orderStatus ?? '';
        return s == 'InProgress' || s == 'Delivered';
      }).toList()
          : controller.orders.where((order) {
        final apiStatus = status == 'In Process' ? 'InProgress' : 'Delivered';
        return (order.orderStatus ?? '') == apiStatus;
      }).toList();


      if (filteredOrders.isEmpty) {
        return const Center(child: Text('No orders found'));
      }

      return ListView.builder(
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          final order = filteredOrders[index];
          debugPrint('Rendering order status: ${order.orderStatus}');
          final displayStatus = order.orderStatus == 'InProgress' ? 'In Process' : 'Completed';
          final orderId = order.id ?? 'unknown';
          final coords = order.location?.coordinates;

          // Start resolving location if not already done
          if (coords != null &&
              !controller.locationNames.containsKey(orderId)) {
            controller.resolveLocation(
                orderId, coords[1], coords[0]); // ✅ latitude, longitude
          }

          final locationName =
              controller.locationNames[orderId] ?? "Loading location...";

          return OrderHistoryCard(
            emergency: order.emergency ?? false,
            emergencyImage: AppImages.emergency,
            orderId: order.id ?? 'N/A',
            orderDate: order.createdAt?.toString() ?? 'Unknown',
            fuelQuantity: '${order.amount ?? 0} gallons',
            fuelType: order.fuelType ?? 'Unknown',
            price: (order.finalAmountOfPayment ?? 0.0).toStringAsFixed(2),
            status: displayStatus,
            buttonText1: _getButtonText1(order.orderStatus ?? ''),
            buttonText2: _getButtonText2(order.orderStatus ?? ''),
            onButton1Pressed: () {
              _navigateButton1(order.orderStatus ?? '', order.id);
            },
            onButton2Pressed: () {
              controller.getSingleOrder(order.id ?? 'N/A',order.amount.toString(),locationName);
            },
          );
        },
      );
    });
  }

  String? _getButtonText1(String apiStatus) {
    switch (apiStatus) {
      case 'Delivered':
        return 'Re-book';
      default:
        return null; // No button for InProgress
    }
  }

  String? _getButtonText2(String apiStatus) {
    switch (apiStatus) {
      case 'InProgress':
      case 'Delivered':
        return 'View Details';
      default:
        return null;
    }
  }

  void _navigateButton1(String apiStatus, orderId) {
    switch (apiStatus) {
      case 'Delivered':
        final PaymentController paymentController = Get.put(PaymentController());
        paymentController.createPaymentSession(orderId: orderId);
        break;
    }
  }
}
