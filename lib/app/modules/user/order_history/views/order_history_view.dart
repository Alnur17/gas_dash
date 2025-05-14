import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderHistoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OrderHistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
