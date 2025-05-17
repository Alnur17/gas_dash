import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/order_history/views/cancel_order_view.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/order_history_card.dart';
import 'order_details_view.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order History', style: titleStyle),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'In Process'),
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            // Active Orders
            OrderStatusSection(status: 'In Process'),
            // Pending Orders
            OrderStatusSection(status: 'Completed'),
            // Completed Orders
            OrderStatusSection(status: 'Canceled'),
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
            _navigateButton1(status);
          },
          onButton2Pressed: () {
            Get.to(() => OrderDetailsView());
          },
        ),
      ],
    );
  }

  String? _getButtonText1(String status) {
    switch (status) {
      case 'In Process':
        return 'Cancel';
      case 'Completed':
        return 'Re-book';
      case 'Canceled':
        return 'Request to Refund';
      default:
        return null;
    }
  }

  String? _getButtonText2(String status) {
    switch (status) {
      case 'In Process':
        return 'View Details';
      case 'Completed':
        return 'View Details';
      case 'Canceled':
        return 'View Details';
      default:
        return null;
    }
  }

  void _navigateButton1(String status) {
    switch (status) {
      case 'In Process':
        Get.to(() => CancelOrderView());
        break;
      case 'Completed':
        SizedBox();
        break;
      case 'Canceled':
        SizedBox();
        break;
    }
  }
}
