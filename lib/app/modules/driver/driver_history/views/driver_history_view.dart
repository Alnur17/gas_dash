import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_order_details_view.dart';
import 'package:gas_dash/common/helper/order_history_card.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';

class DriverHistoryView extends StatefulWidget {
  const DriverHistoryView({super.key});

  @override
  State<DriverHistoryView> createState() => _DriverHistoryViewState();
}

class _DriverHistoryViewState extends State<DriverHistoryView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order History'),
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
            //dividerColor: AppColors.transparent,
          ),
        ),
        body: TabBarView(
          children: [
            // Active Orders
            OrderStatusSection(status: 'Active'),
            // Pending Orders
            OrderStatusSection(status: 'Pending'),
            // Completed Orders
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
  Widget build(BuildContext context) {
    return ListView(
      children: [
        OrderHistoryCard(
          orderId: '5758',
          orderDate: '10 Dec 2025 at 10:39 AM',
          fuelQuantity: '15 Litres',
          fuelType: 'Premium Fuel',
          price: '65',
          status: status,
          buttonText1: _getButtonText1(status),
          buttonText2: _getButtonText2(status),
          onButton1Pressed: () {
            debugPrint('$status order started!');
          },
          onButton2Pressed: () {
            Get.to(()=> DriverOrderDetailsView());
          },
        ),
      ],
    );
  }
  String? _getButtonText1(String status) {
    switch (status) {
      case 'Active':
        return 'Start Order';
      case 'Pending':
        return 'Accept';
      case 'Completed':
        return null; // No button for Completed
      default:
        return null;
    }
  }

  // Get button text for Button 2 based on status
  String? _getButtonText2(String status) {
    switch (status) {
      case 'Active':
        return 'View Details';
      case 'Pending':
        return 'View Details';
      case 'Completed':
        return 'View Details';
      default:
        return null;
    }
  }
}
