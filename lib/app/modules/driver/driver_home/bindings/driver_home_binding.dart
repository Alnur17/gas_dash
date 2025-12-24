import 'package:get/get.dart';

import 'package:gas_dash/app/modules/driver/driver_home/controllers/driver_notifications_controller.dart';

import '../controllers/driver_home_controller.dart';

class DriverHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverNotificationsController>(
      () => DriverNotificationsController(),
    );
    Get.lazyPut<DriverHomeController>(
      () => DriverHomeController(),
    );
  }
}
