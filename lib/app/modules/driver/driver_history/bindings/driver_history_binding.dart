import 'package:get/get.dart';

import '../controllers/driver_history_controller.dart';

class DriverHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverHistoryController>(
      () => DriverHistoryController(),
    );
  }
}
