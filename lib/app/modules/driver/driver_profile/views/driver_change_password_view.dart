import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DriverChangePasswordView extends GetView {
  const DriverChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DriverChangePasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DriverChangePasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
