import 'package:get/get.dart';

import '../controllers/driver_message_controller.dart';

class DriverMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverMessageController>(
      () => DriverMessageController(),
    );
  }
}
