import 'package:get/get.dart';

import '../controllers/jump_start_car_battery_controller.dart';

class JumpStartCarBatteryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JumpStartCarBatteryController>(
      () => JumpStartCarBatteryController(),
    );
  }
}
