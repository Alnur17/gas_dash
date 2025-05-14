import 'package:get/get.dart';

import '../controllers/driver_earning_controller.dart';

class DriverEarningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverEarningController>(
      () => DriverEarningController(),
    );
  }
}
